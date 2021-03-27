//
//  UISearchBar+Extension.swift
//  ShowingoUIKit
//
//  Created by Евгений Уланов on 27.03.2021.
//

import UIKit

extension UISearchBar {

    var textField : UITextField? {
        if #available(iOS 13.0, *) {
            return self.searchTextField
        } else {
            for view: UIView in (self.subviews[0]).subviews {
                if let textField = view as? UITextField {
                    return textField
                }
            }
        }
        return nil
    }
}
