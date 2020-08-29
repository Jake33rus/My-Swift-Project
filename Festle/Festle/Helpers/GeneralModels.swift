//
//  GeneralModels.swift
//  Festle
//
//  Created by Евгений Уланов on 20.07.2020.
//  Copyright © 2020 Евгений Уланов. All rights reserved.
//

import UIKit

struct FestCell {
    let image: UIImage
    let nameLabel: String
    let descriptionLabel: String
    let isPaid: Bool
}

struct GuidCell{
    let photo: UIImage
    let nameLabel: String
    let coutTour: Int
    let city: String
    let likes: Int
}

class GuidInfo{
    let photo: UIImage
    let name:String
    let countTour: Int
    let city: String
    let likes: Int
    
    init(photo: UIImage, name: String, countTour: Int, city: String,
         likes: Int) {
        self.photo = photo
        self.name = name
        self.countTour = countTour
        self.city = city
        self.likes = likes
    }
}

class FullGuidInfo: GuidInfo{
    let contacts: String
    let aboutInfo: String
    let languages: String
    let upcomingTours: [FestCell]
    init(photo: UIImage, name: String, countTour: Int, city: String, likes: Int, contacts: String, aboutInfo: String, languages: String, upcomingTours: [FestCell]) {
        self.contacts = contacts
        self.aboutInfo = aboutInfo
        self.languages = languages
        self.upcomingTours = upcomingTours
        super.init(photo: photo, name: name, countTour: countTour, city: city, likes: likes)
    }
}

struct Tour{
    let excursionName: String
    let objectCount: Int
    let hoursCount: Double
    let excursionDescr: String
    let excursionPhoto: UIImage
    let tourPoints: [TourPoint]
    let isStreaming: Bool
}

struct TourPoint{
    let pointNumber: Int
    let placeName: String
    let placeAdress: String
    let placeDescr: String
    let placePhoto: UIImage
}
