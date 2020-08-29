//
//  String+Height.swift
//  NewsFeedVK
//
//  Created by Евгений Уланов on 17.06.2020.
//  Copyright © 2020 Евгений Уланов. All rights reserved.
//

import UIKit
import Foundation

extension String {
    
    func height(width:CGFloat, font: UIFont) -> CGFloat {
        let textSize = CGSize(width: width, height: .greatestFiniteMagnitude)
        
        let size = self.boundingRect(with: textSize,
                                     options: .usesLineFragmentOrigin,
                                     attributes: [NSAttributedString.Key.font : font],
                                     context: nil)
        return ceil(size.height)
    }
}
