//
//  ViewController.swift
//  TConverter
//
//  Created by Евгений Уланов on 21.03.2020.
//  Copyright © 2020 Евгений Уланов. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var cenliusLabel: UILabel!
    @IBOutlet weak var fahrenheitLabel: UILabel!
    @IBOutlet weak var slider: UISlider! {
        didSet {
            slider.minimumValue = 0
            slider.maximumValue = 100
            slider.value = 0
        }
    }
    @IBAction func sliderChanged(_ sender: UISlider) {
        let tempratureCelsius = Int(round(sender.value))
        cenliusLabel.text = "\(tempratureCelsius)ºC"
        let tempratureFahrenheit = Int(round((sender.value * 9 / 5) + 32))
        fahrenheitLabel.text = "\(tempratureFahrenheit)ºF"
    }
}

