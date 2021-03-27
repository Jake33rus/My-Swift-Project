//
//  BottomSheetTransitioningController.swift
//  ShowingoUIKit
//
//  Created by Евгений Уланов on 21.03.2021.
//

import UIKit

/// This is a class, that have ability to perform and manage custom presentation transition.
///
/// It conforms to protocols `UIPresentationController` and `UIViewControllerTransitioningDelegate`,
/// and have no custom public interface - it's just overrides initializer, properties and functions,
/// to provide desired behavior.
///
/// This example shows, how it can be used inside router of the VIP/VIPER module.
///
///     let shade = SomeShadeComplientViewController()
///     let coverTransitioningController = BottomSheetTransitioningController(presentedViewController: shade,
///                                                                        presenting: selfViewController)
///     toViewController.transitioningDelegate = coverTransitioningController
///     selfViewController.present(shade, animated: true)
///
/// To support this presentation type, subclass of the UIViewController, that want to be presented as cover,
/// must define needed size and set it up to it's own property `preferredContentSize`.
///
/// This example for presentedViewController, that will be correctly swonw by BottomSheetTransitioningController.
///
///     override func viewWillAppear(_ animated: Bool) {
///         super.viewWillAppear(animated)
///         updateHeight()
///     }
///     // and/or
///     override func viewWillLayoutSubviews() {
///         super.viewWillLayoutSubviews()
///         updateHeight()
///     }
///     // and/or
///     override func viewDidLayoutSubviews() {
///         super.viewDidLayoutSubviews()
///         updateHeight()
///     }
///     // Constants.defaultContentHeight can be replaced with custom calculations.
///     private func updateHeight() {
///         preferredContentSize = CGSize(width: view.width,
///                                       height: Constants.defaultContentHeight)
///     }
///
/// Note that height can be dynamically calculated, based on the layout or another behavior.
/// All calculations will be nicely handled by the BottomSheetTransitioningController.

public final class BottomSheetTransitioningController: UIPresentationController {
    
    private struct Constants {
        static let containerStyle = "bottomSheetTransitioningContainer"
        static let dimmingStyle = "bottomSheetTransitioningBackgroundDimmer"
        static let dimmerViewOpacity: CGFloat = 0.8
        static let containerTopInset: CGFloat = 50.0
        static let containerBottomInset: CGFloat = 6.0
        static let containerCornerRadius: CGFloat = 16.0
        static let containerShadowRadius: CGFloat = 16.0
        static let containerShadowOpacity: Float = 0.48
        static let containerShadowOffset = CGSize(width: 0.0, height: -8.0)
        static let springAnimationDuration: TimeInterval = 0.44
        static let springAnimationDamping: CGFloat = 0.88
        static let velocityDismiss: CGFloat = 300
        static let percentDismiss: CGFloat = 0.3 // 30%
    }
    
// MARK: - Properties
    
    private lazy var dimmingView: BottomSheetTouchTransmittingView = {
        let newDimmingView = BottomSheetTouchTransmittingView(frame: containerViewBounds)
        newDimmingView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        newDimmingView.isOpaque = false
        newDimmingView.alpha = 0.0

        // Если необходимо передавать тапы по фоновому вью на презентующий контроллер, используем touchReceivingView,
        // при этом не навешиваем обработку закрывающего тапа по фоновому вью
        newDimmingView.touchReceivingView = touchReceivingView
        if touchReceivingView == nil {
            let tapRecognizer = UITapGestureRecognizer(target: self,
                                                       action: #selector(BottomSheetTransitioningController.handleDimmingViewTap))
            newDimmingView.addGestureRecognizer(tapRecognizer)
        }

        return newDimmingView
    }()
    
    private lazy var overallPresentationWrappingView: UIView = {
        let newWrapperView = UIView(frame: frameOfPresentedViewInContainerView)
        newWrapperView.layer.shadowOpacity = Constants.containerShadowOpacity
        newWrapperView.layer.shadowRadius = Constants.containerShadowRadius
        newWrapperView.layer.shadowOffset =  Constants.containerShadowOffset
        let panGesture = UIPanGestureRecognizer(target: self,
                                                action: #selector(BottomSheetTransitioningController.handleUserInteraction(_:)))
        newWrapperView.addGestureRecognizer(panGesture)
        panGesture.delegate = self
        panGestureRecognizer = panGesture
        return newWrapperView
    }()
    
    private lazy var presentationRoundedContainerView: UIView = {
        let presentationRoundedContainerView = UIView(frame: .zero)
        presentationRoundedContainerView.translatesAutoresizingMaskIntoConstraints = false
        presentationRoundedContainerView.layer.masksToBounds = true
        presentationRoundedContainerView.layer.cornerRadius = Constants.containerCornerRadius
        return presentationRoundedContainerView
    }()
    
    private lazy var presentedViewControllerWrapperView: UIView = {
        let presentedViewControllerWrapperView = UIView(frame: .zero)
        presentedViewControllerWrapperView.translatesAutoresizingMaskIntoConstraints = false
        return presentedViewControllerWrapperView
    }()
    
    private var panGestureRecognizer: UIPanGestureRecognizer?
    private var userInteractionOrigin: CGPoint = .zero
    private var userInteractionDetected = false
    private var skipContainerViewLayoutEvent = false
    private var dismissalProcess = false
    private var cancelledOtherGestureRecognizers = NSHashTable<AnyObject>(options: [.weakMemory, .objectPointerPersonality])

    /// Флаг отвечающий за затемнение фона
    public var shouldDim: Bool = true

    /// Контроллер, который будет получать тапы по фоновому вью
    public var touchReceivingView: UIView?
    
    private var containerViewBounds: CGRect {
        return containerView?.bounds ?? .zero
    }
    
    override public var presentedView: UIView? {
        return overallPresentationWrappingView
    }
    
    override public var frameOfPresentedViewInContainerView: CGRect {
        let presentedViewContentSize = size(forChildContentContainer: presentedViewController,
                                            withParentContainerSize: containerViewBounds.size)
        var presentedViewControllerFrame = containerViewBounds
        var customHeight: CGFloat = presentedViewContentSize.height + Constants.containerBottomInset
        var safeAreaTopInset: CGFloat = 0.0
        if #available(iOS 11.0, *) {
            customHeight += presentedViewController.view.safeAreaInsets.bottom
            safeAreaTopInset += presentedViewController.view.safeAreaInsets.top
        }
        
        let maxHeight = containerViewBounds.maxY - Constants.containerTopInset
        if maxHeight < (customHeight + safeAreaTopInset) {
            customHeight = maxHeight
        }
        presentedViewControllerFrame.size.height = customHeight
        presentedViewControllerFrame.origin.y = containerViewBounds.maxY - customHeight

        adjustScrollingIfNeeded(in: presentedViewController.view)

        return presentedViewControllerFrame
    }

    private func adjustScrollingIfNeeded(in contentView: UIView) {
        guard let scrollView = findScrollViewToAdjust(in: contentView) else {
            return
        }
        scrollView.contentInset.bottom = Constants.containerBottomInset
    }

    private func findScrollViewToAdjust(in contentView: UIView) -> UIScrollView? {
        var bottommostY: CGFloat = -1
        var result: UIScrollView? = nil

        enumerateSubviews(including: contentView) { subview, skipSubviews in
            let maxY = subview.frame.maxY
            let maxYInContainerCoordinates = contentView.convert(CGPoint(x: 0, y: maxY), from: subview).y
            let currentViewIsBottommost = maxYInContainerCoordinates > bottommostY
            bottommostY = max(bottommostY, maxYInContainerCoordinates)

            guard let scrollView = subview as? UIScrollView else {
                return
            }

            if (currentViewIsBottommost) {
                result = scrollView
            } else {
                result = nil;
            }

            skipSubviews = true
        }

        return result
    }

    private func enumerateSubviews(including view: UIView, with block: (UIView, inout Bool) -> Void) {
        var skipSubviews = false
        block(view, &skipSubviews)
        let subviews = view.subviews
        if subviews.isEmpty || skipSubviews {
            return
        }

        subviews.forEach { subview in
            enumerateSubviews(including: subview, with: block)
        }
    }
    
// MARK: - Constructor
    override public init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        presentedViewController.modalPresentationStyle = .custom
    }
}

// MARK: - Actions
extension BottomSheetTransitioningController {
    
    @objc private func handleDimmingViewTap() {
        closeShade()
    }
    
    @objc private func handleUserInteraction(_ gestureRecognizer: UIPanGestureRecognizer) {
        guard
            let container = presentedView,
            let panGesture = panGestureRecognizer,
            panGesture === gestureRecognizer,
            // используется в качестве знаменателя ниже, не может быть 0
            overallPresentationWrappingView.frame.size.height != 0
        else {
            return
        }

        let translation = panGesture.translation(in: container)
        var yOrigin = frameOfPresentedViewInContainerView.origin.y
        let dismissalProgress = translation.y / overallPresentationWrappingView.frame.size.height
        let velocity = gestureRecognizer.velocity(in: container).y
        dismissalProcess = (translation.y >= 0)
        
        switch gestureRecognizer.state {
        case .began:
            panGesture.setTranslation(.zero, in: container)
            userInteractionOrigin = frameOfPresentedViewInContainerView.origin
            userInteractionDetected = true
        case .changed:

            skipContainerViewLayoutEvent = true

            if translation.y < 0 {
                yOrigin = userInteractionOrigin.y - sqrt(abs(translation.y))
            } else {
                yOrigin += translation.y
            }
            container.frame = CGRect(x: frameOfPresentedViewInContainerView.origin.x,
                                     y: yOrigin,
                                     width: frameOfPresentedViewInContainerView.width,
                                     height: frameOfPresentedViewInContainerView.height)
        case
            .ended where velocity > 0 && (abs(velocity) > Constants.velocityDismiss || dismissalProgress > Constants.percentDismiss),
            .ended where velocity < 0 && (abs(velocity) < Constants.velocityDismiss) && dismissalProgress > Constants.percentDismiss:
            closeShade()
            activateDeactivatedOtherGestureRecognizers()
        default:
            adjustFramesAtUserInteraction()
            activateDeactivatedOtherGestureRecognizers()
        }
    }

    private func activateDeactivatedOtherGestureRecognizers() {
        cancelledOtherGestureRecognizers.allObjects.compactMap { $0 as? UIGestureRecognizer }.forEach {
            $0.isEnabled = true
        }
    }
    
    private func handleContainerViewLayout() {
        if skipContainerViewLayoutEvent || dismissalProcess {
            return
        }
        if userInteractionDetected {
            adjustFramesAtUserInteraction()
        } else {
            adjustFrames()
        }
    }
    
    private func closeShade() {
        skipContainerViewLayoutEvent = true

        presentedViewController.dismiss(animated: true) { [weak self] in
            self?.skipContainerViewLayoutEvent = false
        }
    }
}

// MARK: - Animations
extension BottomSheetTransitioningController {
    
    private func adjustFramesAtUserInteraction(velocity: CGPoint? = nil) {
        let frameUpdateRequired = overallPresentationWrappingView.frame.origin.y > userInteractionOrigin.y
        let animations = {
            self.overallPresentationWrappingView.frame.origin = self.userInteractionOrigin
            if !frameUpdateRequired {
                self.overallPresentationWrappingView.frame.size.height = self.frameOfPresentedViewInContainerView.height
                self.overallPresentationWrappingView.layoutIfNeeded()
            }
        }
        let completion: (Bool) -> Void = { (_) in
            self.skipContainerViewLayoutEvent = false
            self.userInteractionDetected = false
            self.dismissalProcess = false
            if frameUpdateRequired {
                UIView.animate(withDuration: 0.2) {
                    self.overallPresentationWrappingView.frame = self.frameOfPresentedViewInContainerView
                }
            }
        }
        UIView.animate(withDuration: Constants.springAnimationDuration,
                       delay: 0.0,
                       usingSpringWithDamping: Constants.springAnimationDamping,
                       initialSpringVelocity: 0.0,
                       options: .beginFromCurrentState,
                       animations: animations,
                       completion: completion)
    }
    
    private func adjustFrames() {
        let frameUpdateRequiredImmediately = overallPresentationWrappingView.frame.size.height < frameOfPresentedViewInContainerView.size.height
        let animations = {
            self.overallPresentationWrappingView.frame.origin = self.frameOfPresentedViewInContainerView.origin
        }
        let completion: (Bool) -> Void = { (_) in
            if frameUpdateRequiredImmediately {
                self.overallPresentationWrappingView.frame = self.frameOfPresentedViewInContainerView
            } else {
                // тут мы гарантированно скипаем проход текущего цикла для плавности, так как из-за прохода автолэйаута могут быть рывки при изменении высоты контейнера
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    if self.userInteractionDetected || self.dismissalProcess {
                        return
                    }
                    self.overallPresentationWrappingView.frame = self.frameOfPresentedViewInContainerView
                }
            }
        }
        UIView.animate(withDuration: Constants.springAnimationDuration,
                       delay: 0.0,
                       usingSpringWithDamping: Constants.springAnimationDamping,
                       initialSpringVelocity: 0.0,
                       options: .beginFromCurrentState,
                       animations: animations,
                       completion: completion)
    }
}

// MARK: - Layout
extension BottomSheetTransitioningController {
    
    private func setupLayout(with presentedViewControllerView: UIView) {
        presentedViewControllerView.frame = presentedViewControllerWrapperView.bounds
        presentedViewControllerView.translatesAutoresizingMaskIntoConstraints = false

        containerView?.addSubview(dimmingView)
        
        overallPresentationWrappingView.addSubview(presentationRoundedContainerView)
        presentationRoundedContainerView.addSubview(presentedViewControllerWrapperView)
        presentedViewControllerWrapperView.addSubview(presentedViewControllerView)
        
        presentationRoundedContainerView.topAnchor ~= overallPresentationWrappingView.topAnchor
        presentationRoundedContainerView.leftAnchor ~= overallPresentationWrappingView.leftAnchor
        presentationRoundedContainerView.rightAnchor ~= overallPresentationWrappingView.rightAnchor
        presentationRoundedContainerView.bottomAnchor ~= overallPresentationWrappingView.bottomAnchor + Constants.containerTopInset
        
        presentedViewControllerWrapperView.topAnchor ~= presentationRoundedContainerView.topAnchor
        presentedViewControllerWrapperView.leftAnchor ~= presentationRoundedContainerView.leftAnchor
        presentedViewControllerWrapperView.rightAnchor ~= presentationRoundedContainerView.rightAnchor
        presentedViewControllerWrapperView.bottomAnchor ~= presentationRoundedContainerView.bottomAnchor - Constants.containerTopInset
        
        presentedViewControllerView.topAnchor ~= presentedViewControllerWrapperView.topAnchor
        presentedViewControllerView.leftAnchor ~= presentedViewControllerWrapperView.leftAnchor
        presentedViewControllerView.rightAnchor ~= presentedViewControllerWrapperView.rightAnchor
        presentedViewControllerView.bottomAnchor ~= presentedViewControllerWrapperView.bottomAnchor
    }
}

// MARK: - UIContentContainer
extension BottomSheetTransitioningController {
    
    override public func size(forChildContentContainer container: UIContentContainer, withParentContainerSize parentSize: CGSize) -> CGSize {
        guard let controller = container as? UIViewController else {
            return super.size(forChildContentContainer: container, withParentContainerSize: parentSize)
        }
        if (controller != self.presentedViewController) {
            return super.size(forChildContentContainer: container, withParentContainerSize: parentSize)
        } else {
            return controller.preferredContentSize
        }
    }
    
    override public func preferredContentSizeDidChange(forChildContentContainer container: UIContentContainer) {
        super.preferredContentSizeDidChange(forChildContentContainer: container)
        guard (container as? UIViewController) == presentedViewController else {
            return
        }
        if userInteractionDetected {
            if !dismissalProcess {
                panGestureRecognizer?.isEnabled = false
                panGestureRecognizer?.isEnabled = true
            }
            skipContainerViewLayoutEvent = false
            if userInteractionOrigin.y > frameOfPresentedViewInContainerView.origin.y {
                userInteractionDetected = false
            } else {
                userInteractionOrigin.y = frameOfPresentedViewInContainerView.origin.y
            }
        }
        containerView?.setNeedsLayout()
    }
    
    override public func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()
        handleContainerViewLayout()
    }
    
    override public func containerViewDidLayoutSubviews() {
        super.containerViewDidLayoutSubviews()
        handleContainerViewLayout()
    }
}

// MARK: - Presentation
extension BottomSheetTransitioningController {
    
    override public func presentationTransitionWillBegin() {
        guard let presentedViewControllerView = super.presentedView,
            let transitionCoordinator = presentingViewController.transitionCoordinator
            else { return }
        setupLayout(with: presentedViewControllerView)

        dimmingView.frame = containerViewBounds
        if shouldDim {
            transitionCoordinator.animate(alongsideTransition: { [weak self] (_) in
                self?.dimmingView.alpha = Constants.dimmerViewOpacity
            })
        }
    }
    
    override public func presentationTransitionDidEnd(_ completed: Bool) {
        if completed {
            return
        }
        dimmingView.removeFromSuperview()
        overallPresentationWrappingView.removeFromSuperview()
    }
    
    override public func dismissalTransitionWillBegin() {
        guard let transitionCoordinator = presentingViewController.transitionCoordinator else { return }
        dismissalProcess = true
        if shouldDim {
            transitionCoordinator.animate(alongsideTransition: { [weak self] (_) in
                self?.dimmingView.alpha = 0.0
            })
        }
    }
    
    override public func dismissalTransitionDidEnd(_ completed: Bool) {
        dismissalProcess = false
        if !completed {
            return
        }
        dimmingView.removeFromSuperview()
        overallPresentationWrappingView.removeFromSuperview()
    }
}

// MARK: - UIViewControllerTransitioningDelegate
extension BottomSheetTransitioningController: UIViewControllerTransitioningDelegate {
    
    public func presentationController(forPresented presented: UIViewController,
                                       presenting: UIViewController?,
                                       source: UIViewController) -> UIPresentationController? {
        return self
    }
    
    public func animationController(forPresented presented: UIViewController,
                                    presenting: UIViewController,
                                    source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return BottomSheetTransitioningAnimator(direction: .presenting)
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let velocity = panGestureRecognizer?.velocity(in: presentedView).y
        return BottomSheetTransitioningAnimator(direction: .dismissing(velocity: velocity))
    }
}

extension BottomSheetTransitioningController: UIGestureRecognizerDelegate {
    public func gestureRecognizer(
        _ gestureRecognizer: UIGestureRecognizer,
        shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        let selector = Selector(stringLiteral: "scrollView")
        guard
            let container = presentedView, let panGestureRecognizer = gestureRecognizer as? UIPanGestureRecognizer,
            otherGestureRecognizer is UIPanGestureRecognizer,
            otherGestureRecognizer.responds(to: selector),
            let otherScrollView = otherGestureRecognizer.perform(selector)?.takeUnretainedValue() as? UIScrollView
        else {
            return true
        }

        let velocity = panGestureRecognizer.velocity(in: container).y
        guard velocity != 0 else { return false }
        let gestureDown = velocity > 0

        let isEdgePanGestureDown = gestureDown && otherScrollView.contentOffset.y <= 0
        let isEdgePanGestureUp = !gestureDown && (otherScrollView.contentOffset.y + otherScrollView.bounds.size.height) >= otherScrollView.contentSize.height

        if isEdgePanGestureUp || isEdgePanGestureDown {
            otherGestureRecognizer.isEnabled = false
            cancelledOtherGestureRecognizers.add(otherGestureRecognizer)
            return true
        } else {
            return false
        }
    }
}
