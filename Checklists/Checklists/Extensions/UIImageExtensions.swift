//
//  UIImageExtensions.swift
//  Checklists
//
//  Created by Евгений Уланов on 01.10.2020.
//

import UIKit

extension CIImage {
    var image: UIImage? {
        let image = UIImage(ciImage: self)
        UIGraphicsBeginImageContextWithOptions(image.size, false, image.scale)
        defer { UIGraphicsEndImageContext() }
        image.draw(in: CGRect(origin: .zero, size: image.size))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}
extension UIImage {
    func applying(saturation value: NSNumber) -> UIImage? {
        return CIImage(image: self)?
            .applyingFilter("CIColorControls", parameters: [kCIInputSaturationKey: value])
            .image
    }  // Swift 3 uses withInputParameters instead of parameters
    var grayscale: UIImage? {
        return applying(saturation: 0)
    }
}
