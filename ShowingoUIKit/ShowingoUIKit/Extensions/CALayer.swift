//
//  CALayer.swift
//  ShowingoUIKit
//
//  Created by Евгений Уланов on 21.03.2021.
//

import UIKit

public extension CALayer {
    @objc func shake() {
        let leftXCoordinateShift: CGFloat = -10
        let rightXCoordinateShift: CGFloat = 10
        let animation = CAKeyframeAnimation(keyPath: "transform")
        let leftWobble = NSValue(caTransform3D: CATransform3DMakeTranslation(leftXCoordinateShift, 0, 0))
        let rightWobble = NSValue(caTransform3D: CATransform3DMakeTranslation(rightXCoordinateShift, 0, 0))
        animation.values = [leftWobble, rightWobble]
        animation.autoreverses = true
        animation.repeatCount = 2
        animation.duration = 0.07

        add(animation, forKey: nil)
    }
}
