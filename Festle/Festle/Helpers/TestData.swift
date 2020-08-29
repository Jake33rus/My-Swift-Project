//
//  TestData.swift
//  Festle
//
//  Created by Евгений Уланов on 07.08.2020.
//  Copyright © 2020 Евгений Уланов. All rights reserved.
//

import Foundation
import UIKit

struct TestData{
   static let favoriteGuids: [GuidCell] = [GuidCell(photo: UIImage(named: "face")!,
                                                         nameLabel: "Joe Testers",
                                                         coutTour: 200,
                                                         city: "Moscow",
                                                         likes: 250),
                                                GuidCell(photo: UIImage(named: "face")!,
                                                         nameLabel: "Mark Testers",
                                                         coutTour: 82,
                                                         city: "Roma",
                                                         likes: 25000),
                                                GuidCell(photo: UIImage(named: "face")!,
                                                         nameLabel: "Joe Testers",
                                                         coutTour: 171,
                                                         city: "Praga",
                                                         likes: 4823)]
    static let favoriteFests: [FestCell] = [FestCell(image: UIImage(named: "nature1")!,
                                                         nameLabel: "По озерам Тайги",
                                                         descriptionLabel: "блаблаблаблаблаблаблаблаблаблаблаблаблаблаблаблаблабла",
                                                         isPaid: true),
                                                FestCell(image: UIImage(named: "nature2")!,
                                                         nameLabel: "Красоты природы Австралии",
                                                         descriptionLabel: "блаблаблаблаблаблаблаблаблаблаблаблаблаблаблаблаблабла",
                                                         isPaid: false),
                                                FestCell(image: UIImage(named: "nature3")!,
                                                         nameLabel: "Красоты природы Австралии",
                                                         descriptionLabel: "блаблаблаблаблаблаблаблаблаблаблаблаблаблаблаблаблабла",
                                                         isPaid: false)]
    
    static let testGuid:FullGuidInfo = FullGuidInfo(photo: UIImage(named: "face")!,
                                                    name: "Test Testerov",
                                                    countTour: 3,
                                                    city: "Moscow",
                                                    likes: 20,
                                                    contacts: "+78005553535\nmail@mail.com",
                                                    aboutInfo: "I am guid", languages: "Russian, English",
                                                    upcomingTours: favoriteFests)
    
    static let testTour:Tour = Tour(excursionName: "Best tour from Moscow",
                                    objectCount: 2,
                                    hoursCount: 4,
                                    excursionDescr: "blablabla",
                                    excursionPhoto: UIImage(named: "nature1")!.darkened()!,
                                    tourPoints: TestData.tourPoints,
                                    isStreaming: false)
    
    static let tourPoints: [TourPoint] = [TourPoint(pointNumber: 1,
                                                   placeName: "Red Square",
                                                   placeAdress: "Moscow, takaya street, 1, 2",
                                                   placeDescr: "This is Red Square",
                                                   placePhoto: UIImage(named: "nature2")!.darkened()!),
                                          TourPoint(pointNumber: 2,
                                          placeName: "GUM",
                                          placeAdress: "Moscow, drugaya street, 1, 3",
                                          placeDescr: "This is GUM - MEGA SSSR UNIVERMAG",
                                          placePhoto: UIImage(named: "nature3")!.darkened()!),
//                                        TourPoint(pointNumber: 3,
//                                        placeName: "Red Square",
//                                        placeAdress: "Moscow, takaya street, 1, 2",
//                                        placeDescr: "This is Red Square",
//                                        placePhoto: UIImage(named: "nature2")!.darkened()!),
    ]
}

    
