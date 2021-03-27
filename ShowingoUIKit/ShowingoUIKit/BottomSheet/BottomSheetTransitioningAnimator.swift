//
//  BottomSheetTransitioningAnimator.swift
//  ShowingoUIKit
//
//  Created by Евгений Уланов on 21.03.2021.
//

import UIKit

/// In fact - this is a part of the BottomSheetTransitioningController,
/// performs animation for transition, that it's currently manage.
///
/// Should not be used directly in normal cases.
///
/// This example show how it can be used:
///
///     let presentationAnimator = BottomSheetTransitioningAnimator(isPresenting: true)
///     // or
///     let dismissalAnimator = BottomSheetTransitioningAnimator(isPresenting: false)
///
/// - Returns: An object to animate custom presentation trantision as cover shade,
/// that slides from bottom to it's top position and vise versa.

final class BottomSheetTransitioningAnimator: NSObject {

    private let defaultPresentingDuration: TimeInterval = 0.66
    private let defaultDismissingDuration: TimeInterval = 0.33
    private let dismissingVelocity: CGFloat?

    private var isPresenting: Bool

    required init(direction: Direction) {
        self.isPresenting = direction.isPresenting
        switch direction {
        case .dismissing(let velocity):
            dismissingVelocity = velocity
        default:
            dismissingVelocity = nil
        }

        super.init()
    }
}

extension BottomSheetTransitioningAnimator {
    enum Direction {
        case presenting
        case dismissing(velocity: CGFloat?)

        var isPresenting: Bool {
            switch self {
            case .presenting:
                return true
            case .dismissing:
                return false
            }
        }
    }
}

extension BottomSheetTransitioningAnimator: UIViewControllerAnimatedTransitioning {
    private func getDismissingDuration(transitionContext: UIViewControllerContextTransitioning) -> TimeInterval {
        guard !isPresenting else {
            return 0
        }

        guard let velocity = dismissingVelocity else {
            return defaultDismissingDuration
        }

        guard let fromViewController = transitionContext.viewController(forKey: .from) else {
            fatalError("transition corrupted")
        }

        let fromView: UIView = transitionContext.view(forKey: .from) ?? fromViewController.view

        guard let fromViewWindow = fromView.window else {
            return defaultDismissingDuration
        }
        let fromViewPositionInScreen = fromView.convert(CGPoint.zero, to: fromView.window)
        let distanceLeftToDismiss = fromViewWindow.bounds.height - fromViewPositionInScreen.y

        let velociyBasedDuration = Double(distanceLeftToDismiss / velocity)

        return min(velociyBasedDuration, defaultDismissingDuration)
    }

    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        guard let transitionContext = transitionContext else { return 0 }
        if transitionContext.isAnimated {
            return isPresenting ? defaultPresentingDuration : getDismissingDuration(transitionContext: transitionContext)
        } else {
            return 0
        }
    }
    
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromViewController = transitionContext.viewController(forKey: .from),
            let toViewController = transitionContext.viewController(forKey: .to)
            else {
                fatalError("transition corrupted")
        }
        
        let fromView: UIView = transitionContext.view(forKey: .from) ?? fromViewController.view
        let toView: UIView = transitionContext.view(forKey: .to) ?? toViewController.view
        
        var fromViewFinalFrame = transitionContext.finalFrame(for: fromViewController)
        var toViewInitialFrame = transitionContext.initialFrame(for: toViewController)
        let toViewFinalFrame = transitionContext.finalFrame(for: toViewController)
        
        let completion: (Bool) -> Void = { (finished) in
            if !finished {
                return
            }
            let success = !transitionContext.transitionWasCancelled
            if (self.isPresenting && !success) {
                toView.removeFromSuperview()
            }
            if (!self.isPresenting && success) {
                fromView.removeFromSuperview()
            }
            transitionContext.completeTransition(success)
        }
        
        if (isPresenting) {
            let containerView = transitionContext.containerView
            containerView.addSubview(toView)
            toViewInitialFrame.origin = CGPoint.init(x: containerView.bounds.minX, y: containerView.bounds.maxY)
            toViewInitialFrame.size = toViewFinalFrame.size
            toView.frame = toViewInitialFrame
            
            UIView.animate(withDuration: transitionDuration(using: transitionContext),
                           delay: 0,
                           usingSpringWithDamping: 1.0,
                           initialSpringVelocity: 0,
                           options: .beginFromCurrentState,
                           animations: { toView.frame = toViewFinalFrame },
                           completion: completion)
        } else {
            var lengthLeft = fromView.frame.height
            if let fromViewWindow = fromView.window {
                let frameInScreen = fromView.convert(CGPoint.zero, to: fromView.window)
                lengthLeft = fromViewWindow.bounds.height - frameInScreen.y
            }

            fromViewFinalFrame = fromView.frame.offsetBy(dx: 0, dy: lengthLeft)
            
            UIView.animate(withDuration: transitionDuration(using: transitionContext),
                           animations: { fromView.frame = fromViewFinalFrame },
                           completion: completion)
        }
    }
}
