//
//  VolumeButton.swift
//  Checklists
//
//  Created by Евгений Уланов on 25.09.2020.
//

import UIKit

class VolumeButton: UIButton {

    private var shadowLayer: CAShapeLayer!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if shadowLayer == nil {
            shadowLayer = CAShapeLayer()
            shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: 10).cgPath
            shadowLayer.fillColor = #colorLiteral(red: 0.1298420429, green: 0.1298461258, blue: 0.1298439503, alpha: 1)
            
            shadowLayer.shadowColor = UIColor.black.cgColor
            shadowLayer.shadowPath = shadowLayer.path
            shadowLayer.shadowOffset = CGSize(width: 2.0, height: 2.0)
            shadowLayer.shadowOpacity = 0.8
            shadowLayer.shadowRadius = 2
            
            layer.insertSublayer(shadowLayer, at: 0)
            //layer.insertSublayer(shadowLayer, below: nil) // also works
        }
    }
    
}
