//
//  UITableViewExtension.swift
//  Festle
//
//  Created by Евгений Уланов on 01.09.2020.
//  Copyright © 2020 Евгений Уланов. All rights reserved.
//

import UIKit

extension UITableView {
    func showActivityIndicator() {
        DispatchQueue.main.async {
            let activityView = UIActivityIndicatorView(style: .medium)
            self.backgroundView = activityView
            activityView.startAnimating()
        }
    }

    func hideActivityIndicator() {
        DispatchQueue.main.async {
            let activityView = self.backgroundView as! UIActivityIndicatorView
            activityView.stopAnimating()
            self.backgroundView = nil
        }
    }
}
