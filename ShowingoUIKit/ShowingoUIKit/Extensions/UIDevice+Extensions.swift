//
//  UIDevice+Extensions.swift
//  ShowingoUIKit
//
//  Created by Евгений Уланов on 21.03.2021.
//

import UIKit

public extension UIDevice {
    static var isPhone: Bool {
        UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.phone
    }

    static var isIPhone5: Bool {
        isPhone && UIScreen.main.bounds.size.height == 568
    }
}
