//
//  StringExtension.swift
//  ARFaceTrakingDemo
//
//  Created by Евгений Уланов on 31.05.2020.
//  Copyright © 2020 Евгений Уланов. All rights reserved.
//

import UIKit

extension String {
  
  func image() -> UIImage? {
    
    let size = CGSize(width: 20, height: 22)
    
    UIGraphicsBeginImageContextWithOptions(size, false, 0)
    UIColor.clear.set()
    
    let rect = CGRect(origin: .zero, size: size)
    UIRectFill(CGRect(origin: .zero, size: size))
    
    (self as AnyObject).draw(in: rect, withAttributes: [.font: UIFont.systemFont(ofSize: 15)])
    
    let image = UIGraphicsGetImageFromCurrentImageContext()
    
    UIGraphicsEndImageContext()
    
    return image
  }
}

