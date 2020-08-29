//
//  FavoriteFestCell.swift
//  Festle
//
//  Created by Евгений Уланов on 15.07.2020.
//  Copyright © 2020 Евгений Уланов. All rights reserved.
//

import UIKit

class FavoriteFestCell: UITableViewCell {

    @IBOutlet weak var photo: WebImageView! {
        didSet{
            photo?.layer.cornerRadius = photo.frame.size.height / 2
            photo?.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var tourDescriptionLabel: UILabel!
    @IBOutlet weak var tourNameLabel: UILabel!
    @IBOutlet weak var isPaidIndicator: UIImageView!
    public var isPaid: Bool = true{
        didSet {
            isPaidIndicator.isHidden = !isPaid
        }
    }
    
    func config(by festCell: FestCell){
        photo.image = festCell.image
        tourDescriptionLabel.text = festCell.descriptionLabel
        tourNameLabel.text = festCell.nameLabel
        isPaid = festCell.isPaid
    }
}
