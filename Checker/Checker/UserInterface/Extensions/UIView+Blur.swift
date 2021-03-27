//
//  UIView+Blur.swift
//  ShowingoUIKit
//
//  Created by Евгений Уланов on 21.03.2021.
//

import UIKit

private let tagBlur = 3943898

public extension UIView {
    func blurApply(radius: Float) {
        blurCancel()
        let blurView: UIImageView = {
            let item = UIImageView(frame: .zero)
            item.image = image()?.applyBlur(radius: radius)
            item.tag = tagBlur
            return item
        }()
        addSubview(blurView.prepareForAutoLayout())
        blurView.pinEdgesToSuperviewEdges()
    }
}

public extension UIView {
    func blurCancel() {
        viewWithTag(tagBlur)?.removeFromSuperview()
    }
}

private extension UIView {
    func image() -> UIImage? {
        UIGraphicsBeginImageContext(frame.size)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        layer.render(in: context)
        guard let uiImage = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        UIGraphicsEndImageContext()
        guard let cgImage = uiImage.cgImage else { return nil }
        return UIImage(cgImage: cgImage)
    }
}


private extension UIImage {
    func applyBlur(radius: Float) -> UIImage? {
        let ciContext = CIContext(options: nil)
        guard let inputImage = CIImage(image: self) else { return nil }
        guard let mask = CIFilter(name: "CIGaussianBlur") else { return nil }
        mask.setValue(inputImage, forKey: kCIInputImageKey)
        mask.setValue(radius, forKey: kCIInputRadiusKey)
        guard let output = mask.outputImage else { return nil }
        guard let cgImage = ciContext.createCGImage(output, from: inputImage.extent) else { return nil }
        return UIImage(cgImage: cgImage)
    }
}
