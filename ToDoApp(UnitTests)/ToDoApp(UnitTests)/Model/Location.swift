//
//  Location.swift
//  ToDoApp(UnitTests)
//
//  Created by Евгений Уланов on 12.10.2020.
//  Copyright © 2020 Евгений Уланов. All rights reserved.
//

import Foundation
import CoreLocation

struct Location {
    let name: String
    let coordinate: CLLocationCoordinate2D?
    
    var dict: PlistDictionary{
        var dict: PlistDictionary = [:]
        dict["name"] = name
        if let coordinate = coordinate{
            dict["latitude"] = coordinate.latitude
            dict["longitude"] = coordinate.longitude
        }
        return dict
    }
    
    init(name:String, coordinate: CLLocationCoordinate2D? = nil){
        self.name = name
        self.coordinate = coordinate
    }
}

extension Location: Equatable{
    static func == (lhs: Location, rhs: Location) -> Bool{
        guard rhs.coordinate?.latitude == lhs.coordinate?.latitude &&
            lhs.coordinate?.longitude == rhs.coordinate?.longitude &&
            lhs.name == rhs.name else {return false}
        return true
    }
}

extension Location{
    typealias  PlistDictionary = [String : Any]
    init?(dict: PlistDictionary) {
        self.name = dict["name"] as! String
        if let latitude = dict["latitude"] as? Double,
            let longitude = dict["longitude"] as? Double {
            self.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        } else {
            self.coordinate = nil
        }
    }
}
