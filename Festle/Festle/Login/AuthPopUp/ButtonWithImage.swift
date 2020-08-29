//
//  ButtonWithImage.swift
//  Festle
//
//  Created by Евгений Уланов on 06.07.2020.
//  Copyright © 2020 Евгений Уланов. All rights reserved.
//

import UIKit

class ButtonWithImage: UIButton {
    override func layoutSubviews() {
        super.layoutSubviews()
        if imageView != nil {
            imageEdgeInsets = UIEdgeInsets(top: 5, left: 35, bottom: 5, right: 5)
            titleEdgeInsets = UIEdgeInsets(top: 0, left:(imageView?.frame.width)!, bottom: 0, right: 0)
        }
    }
}
