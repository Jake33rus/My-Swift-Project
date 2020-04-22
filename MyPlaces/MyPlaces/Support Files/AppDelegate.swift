//
//  AppDelegate.swift
//  MyPlaces
//
//  Created by Евгений Уланов on 10.04.2020.
//  Copyright © 2020 Евгений Уланов. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let schemaVersion : UInt64 = 2
        
        let config = Realm.Configuration(
            schemaVersion: schemaVersion,
            migrationBlock: {migration, oldSchemaVersion in
                if (oldSchemaVersion < schemaVersion) {
                    
                }
        })
        Realm.Configuration.defaultConfiguration = config
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {

    }


}

