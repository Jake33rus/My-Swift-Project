//
//  StorageManager.swift
//  MyPlaces
//
//  Created by Евгений Уланов on 15.04.2020.
//  Copyright © 2020 Евгений Уланов. All rights reserved.
//

import RealmSwift

let realm = try! Realm()

class StorageManager {
    static func saveObject(_ place: Place) {
        try! realm.write {
            realm.add(place)
        }
    }
    static func deleteObject(_ place: Place){
        try! realm.write {
            realm.delete(place)
        }
    }
}
