//
//  CollectionViewCell.swift
//  Checklists
//
//  Created by Евгений Уланов on 25.09.2020.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    
    
    @IBOutlet weak var checkListName: UILabel!
    @IBOutlet weak var checkListDesc: UITextView!
    @IBOutlet weak var addButton: UIButton!{
        didSet{
            addButton.layer.cornerRadius = 10
            addButton.layer.borderWidth = 1
            addButton.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            if let font = UIFont(name: "TimesNewRomanPSMT", size: 18) {
                addButton.titleLabel?.font = font
                addButton.setTitle("+ Добавить", for: .normal)
                addButton.setTitle("✓ Добавлено", for: .disabled)
                addButton.setTitleColor(#colorLiteral(red: 0.4104530811, green: 0.8392655253, blue: 0.946561873, alpha: 1), for: .disabled)
            }
        }
    }
    @IBOutlet weak var checkListEmoji: UIImageView!
    @IBOutlet weak var view: UIView!{
        didSet{
            view.layer.cornerRadius = 20
            view.layer.borderColor = #colorLiteral(red: 0.4104530811, green: 0.8392655253, blue: 0.946561873, alpha: 1)
            view.layer.borderWidth = 1
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    @IBAction func pressAddCheckList(_ sender: UIButton) {
        addButton.isEnabled = false
        addButton.backgroundColor = #colorLiteral(red: 0.1376692951, green: 0.1381239593, blue: 0.1391835809, alpha: 1)
    }
}
