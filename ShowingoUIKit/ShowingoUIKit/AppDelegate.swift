//
//  AppDelegate.swift
//  ShowingoUIKit
//
//  Created by Евгений Уланов on 21.03.2021.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
    var window : UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let loginController = mainStoryBoard.instantiateViewController(withIdentifier: "HomeViewController")
        self.window?.rootViewController = loginController
        self.window?.makeKeyAndVisible()
        return true
    }
}

