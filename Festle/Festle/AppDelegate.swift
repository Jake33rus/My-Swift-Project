//
//  AppDelegate.swift
//  Festle
//
//  Created by Евгений Уланов on 05.07.2020.
//  Copyright © 2020 Евгений Уланов. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import FBSDKCoreKit
import GoogleSignIn
import GoogleMaps
import GooglePlaces
import AlamofireEasyLogger

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate{


    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        //MARK: Request logging
        
        //MARK: Add GoogleMaps API key
        GMSServices.provideAPIKey("AIzaSyBgeIFuwiU1YubjXSDBaMjZFZyI2xUwzyY")
        GMSPlacesClient.provideAPIKey("AIzaSyBgeIFuwiU1YubjXSDBaMjZFZyI2xUwzyY")
        
        IQKeyboardManager.shared.enable = true
        
        //MARK: Skip LoginVC
        ApplicationDelegate.shared.application( application, didFinishLaunchingWithOptions: launchOptions )
        let accessToken: String? = TokenService.shared.getAccessToken()
        if accessToken != nil{
            let mainStoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let homePage = mainStoryboard.instantiateViewController(withIdentifier: "tabBar") as! UITabBarController
            self.window?.rootViewController = homePage
        }
        return true
    }

    func application( _ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:] ) -> Bool { ApplicationDelegate.shared.application(app, open: url, sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String, annotation: options[UIApplication.OpenURLOptionsKey.annotation])
    }
}

