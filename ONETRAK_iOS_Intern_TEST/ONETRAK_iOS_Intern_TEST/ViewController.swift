//
//  ViewController.swift
//  ONETRAK_iOS_Intern_TEST
//
//  Created by Евгений Уланов on 14.09.2020.
//  Copyright © 2020 Евгений Уланов. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var circleProgressBar: CircleProgressView!
    @IBOutlet weak var valueTextField: UITextField!
    @IBOutlet weak var goButton: UIButton!{
        didSet{
            goButton.layer.cornerRadius = 8
            goButton.clipsToBounds = true
        }
    }
    @IBOutlet weak var maxValueTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func tapGoButton(_ sender: Any) {
        circleProgressBar.progressAnimation(duration: 3, progress: procentCalculate())
    }
    
    func procentCalculate() -> Double{
        let value = (valueTextField.text! as NSString).doubleValue
        let maxValue = (maxValueTextField.text! as NSString).doubleValue
        return value/(maxValue/100)
    }
}

