//
//  TourCollectionViewCell.swift
//  Festle
//
//  Created by Евгений Уланов on 17.08.2020.
//  Copyright © 2020 Евгений Уланов. All rights reserved.
//

import UIKit

class TourCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var tourPhoto: WebImageView!{
        didSet{
            tourPhoto?.layer.cornerRadius = tourPhoto.frame.size.height / 2
            tourPhoto?.clipsToBounds = true
        }
    }
    @IBOutlet weak var tourName: UILabel!
    @IBOutlet weak var isPaid: UIImageView!
    public var isPaidIndicator:Bool = true{
        didSet{
            isPaid.isHidden = !isPaidIndicator
        }
    }
    func config(by tourCell: FestCell){
        tourPhoto.image = tourCell.image
        tourName.text = tourCell.nameLabel
        isPaidIndicator = tourCell.isPaid
    }
}
