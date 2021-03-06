//
//  NavigationBar.swift
//  Festle
//
//  Created by Евгений Уланов on 03.08.2020.
//  Copyright © 2020 Евгений Уланов. All rights reserved.
//

import UIKit

extension UIViewController {
    func hideNavigationBar() {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }

    func showNavigationBar() {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
}
