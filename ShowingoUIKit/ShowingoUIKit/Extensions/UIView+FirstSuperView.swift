//
//  UIView+FirstSuperView.swift
//  ShowingoUIKit
//
//  Created by Евгений Уланов on 21.03.2021.
//

import UIKit

public extension UIView {
    /// Метод проходит вверх по дереву эелементов интерфейса. Вернет первую *superview*,
    /// которая удовлетворит условиям *validator*. Если такой не найдется – вернет *nil*.
    /// - validator: Условие, которое проверяет *superview*
    func firstSuperview<T: UIView>(where validator: (UIView) -> T?) -> T? {
        var currentSuperview = superview
        
        while currentSuperview != nil {
            if let currentSuperview = currentSuperview,
               let appropriateSuperview = validator(currentSuperview) {
                return appropriateSuperview
            }
            currentSuperview = currentSuperview?.superview
        }
        
        return nil
    }
}
