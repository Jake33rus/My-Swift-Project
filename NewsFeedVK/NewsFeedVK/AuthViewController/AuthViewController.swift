//
//  ViewController.swift
//  NewsFeedVK
//
//  Created by Евгений Уланов on 04.06.2020.
//  Copyright © 2020 Евгений Уланов. All rights reserved.
//

import UIKit

class AuthViewController: UIViewController {
    
    private var authService: AuthService!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        authService = SceneDelegate.shared().authService
    }

    @IBAction func singInTouch(_ sender: UIButton) {
        authService.wakeUpSession()
    }
}

