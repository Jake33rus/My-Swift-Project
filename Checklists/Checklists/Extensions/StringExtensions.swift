//
//  StringExtensions.swift
//  Checklists
//
//  Created by Евгений Уланов on 24.09.2020.
//

import UIKit

extension String {
    func image(resize: Int) -> UIImage? {
        let size = CGSize(width: resize, height: resize)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1).set()
        let rect = CGRect(origin: .zero, size: size)
        UIRectFill(CGRect(origin: .zero, size: size))
        (self as AnyObject).draw(in: rect, withAttributes: [.font: UIFont.systemFont(ofSize: CGFloat(resize-5))])
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}
