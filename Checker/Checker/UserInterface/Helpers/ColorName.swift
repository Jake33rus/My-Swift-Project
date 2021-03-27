//
//  ColorName.swift
//  ShowingoUIKit
//
//  Created by Евгений Уланов on 21.03.2021.
//

import UIKit.UIColor
internal typealias Color = UIColor

// MARK: - Colors
internal struct ColorName {
    internal let rgbaValue: UInt32
    internal var color: Color { return Color(named: self) }

    internal static let aqua = ColorName(rgbaValue: 0x00bfc3ff)
}

// MARK: - Implementation Details
internal extension Color {
    convenience init(rgbaValue: UInt32) {
        let red   = CGFloat((rgbaValue >> 24) & 0xff) / 255.0
        let green = CGFloat((rgbaValue >> 16) & 0xff) / 255.0
        let blue  = CGFloat((rgbaValue >>  8) & 0xff) / 255.0
        let alpha = CGFloat((rgbaValue      ) & 0xff) / 255.0

        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}

internal extension Color {
    convenience init(named color: ColorName) {
        self.init(rgbaValue: color.rgbaValue)
    }
}
