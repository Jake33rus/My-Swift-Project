//
//  FavoriteGuideCell.swift
//  Festle
//
//  Created by Евгений Уланов on 15.07.2020.
//  Copyright © 2020 Евгений Уланов. All rights reserved.
//

import UIKit

class FavoriteGuideCell: UITableViewCell {

    @IBOutlet weak var photo: WebImageView!{
        didSet{
            photo?.layer.cornerRadius = photo.frame.size.height / 2
            photo?.clipsToBounds = true
        }
    }
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var likesCount: UILabel!{
        didSet{
            likesCount.setNeedsDisplay()
        }
    }
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var tourCount: UILabel!
    
    func config(by guid: GuidCell){
        photo.image = guid.photo
        nameLabel.text = guid.nameLabel
        likesCount.text = String(guid.likes)
        tourCount.text = String(guid.coutTour)
    }
}
