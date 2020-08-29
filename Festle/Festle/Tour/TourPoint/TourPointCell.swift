//
//  TourPointCell.swift
//  Festle
//
//  Created by Евгений Уланов on 24.08.2020.
//  Copyright © 2020 Евгений Уланов. All rights reserved.
//

import UIKit

class TourPointCell: UITableViewCell {

    @IBOutlet weak var view: UIView!{
        didSet{
            view.layer.cornerRadius = 10
            view.clipsToBounds = true
        }
    }
    @IBOutlet weak var placeName: UILabel!
    @IBOutlet weak var placeAdress: UILabel!
    @IBOutlet weak var placeDescription: UILabel!
    @IBOutlet weak var markNumber: UILabel!
    @IBOutlet weak var placePhoto: UIImageView!{
        didSet{
            placePhoto.layer.cornerRadius = 10
            placePhoto.clipsToBounds = true
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func config(by tourPoint: TourPoint){
        placeName.text = tourPoint.placeName
        placeAdress.text = tourPoint.placeAdress
        placeDescription.text = tourPoint.placeDescr
        markNumber.text = String(tourPoint.pointNumber)
        placePhoto.image = tourPoint.placePhoto
    }
}
