//
//  iconCell.swift
//  Checklists
//
//  Created by Евгений Уланов on 26.09.2020.
//

import UIKit

class IconCell: UICollectionViewCell {
    @IBOutlet weak var iconImage: UIImageView!
    
    override var isSelected: Bool {
        get {
            return super.isSelected;
        }
        set {
            if (super.isSelected != newValue) {
                super.isSelected = newValue
                if (newValue == true) {
                    self.layer.borderWidth = 1
                    self.layer.borderColor = #colorLiteral(red: 0.4513868093, green: 0.9930960536, blue: 1, alpha: 1)
                } else {
                    self.layer.borderWidth = 0
                }
            }
        }
    }
}
