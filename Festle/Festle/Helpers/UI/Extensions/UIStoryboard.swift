//
//  UIStoryboard.swift
//  Festle
//
//  Created by Евгений Уланов on 19.07.2020.
//  Copyright © 2020 Евгений Уланов. All rights reserved.
//
import UIKit

extension UIStoryboard {

    static func instantiate<T: UIViewController>(ofType: T.Type) -> T {
        let storyboard = UIStoryboard(name: String(describing: T.self), bundle: nil)
        guard let viewController = storyboard.instantiateInitialViewController() as? T else {
            fatalError("Can't instantiate \(T.self) from storyboard")
        }
        return viewController
    }

}
