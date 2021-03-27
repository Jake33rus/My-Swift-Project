//
//  UIStackView+Extensions.swift
//  ShowingoUIKit
//
//  Created by Евгений Уланов on 21.03.2021.
//

import UIKit

extension UIStackView {
    func removeArrangedSubviews() {
        arrangedSubviews.forEach { $0.removeFromSuperview() }
    }
}
