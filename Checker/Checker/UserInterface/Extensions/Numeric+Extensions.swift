//
//  Numeric+Extensions.swift
//  ShowingoUIKit
//
//  Created by Евгений Уланов on 27.03.2021.
//

import Foundation

extension Numeric {
    var formattedWithSeparator: String {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = " "
        formatter.numberStyle = .decimal
        return formatter.string(for: self) ?? String(describing: self)
    }
}
