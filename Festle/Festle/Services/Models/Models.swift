//
//  Models.swift
//  Festle
//
//  Created by Евгений Уланов on 26.08.2020.
//  Copyright © 2020 Евгений Уланов. All rights reserved.
//

import Foundation
import UIKit

struct LoginModel: Codable{
    let login, password, platform: String
}

struct LoginResult: Codable{
    let accessToken, refreshToken: String
}

struct LoginModelByExternalApi: Codable{
    let key, name, platform: String
}

struct RegisterModel: Codable{
    let email, nickname, password, platform: String
}

struct RegisterModelByExternalAPI: Codable{
    let email, nickname, platform, externalId, externalName: String
}

struct CreateTourPoint: Codable{
    let name, descriptio: String
    let location, address : String?
    let isAutoGenerate: Bool
    let pointNumber: Int32
}

struct CreateTour: Codable{
    let name, dateTime, description: String
    let isDraft: Bool
    let price: Double
    let length: Float
    let createTourPoints: [CreateTourPoint]
}

struct RoleAPIModel: Codable{
    let name: String
}

struct PhotoAPIModel: Codable{
    let fileName, id: String?
}

struct UserAPIModel: Codable{
    let email, nickname, city, phone, about: String?
    let isGuide: Bool
    let rating: Float
    let role: RoleAPIModel
    let photo: PhotoAPIModel
}

struct TourPointAPIModel: Codable {
    let id: Int32
    let name, description, coords: String?
    let pointNumber: Int32
    let photos: [PhotoAPIModel]?
}

struct TourAPIModel: Codable{
    let id, likeCount: Int32
    let description, name: String?
    let dateTime: String
    let guide: UserAPIModel
    let isDraft: Bool
    let price: Double
    let isFree: Bool = true
    let tourPoints: [TourPointAPIModel]?
    let photos: [PhotoAPIModel]?
    let length: Float
}

struct TourAPIModelPagination: Codable{
    var page, count: Int32
    let data: TourAPIModel?
}

struct UpdateTourPoint: Codable{
    let id, pointNumber: Int32
    let name, description: String
    let isAutoGenerate: Bool
    let location, address: String?
}

struct UpdateTour: Codable{
    let id: Int32
    let name, dateTime, description: String
    let isDraft, isGenerateTourPoint: Bool
    let price: Double
    let length: Float
    let updateTourPoints: [UpdateTourPoint]?
}

struct AddPointToTour: Codable{
    let name, description: String
    let isAutoGenerate: Bool
    let location, address: String?
    let tourId, pointNumber: Int32
}

struct AddTourPhoto: Codable{
    let id: Int32
    let descr: String
    let name: String
    let formFile: CodableImage
}

struct EndTourEdit: Codable{
    let id: Int32
}

struct RemoveTourPhoto: Codable{
    let photoId: String?
}

struct PasswordRestore: Codable{
    let password, prevPassword: String
}

struct ChangeUser: Codable{
    let nickname, email: String
    let isGuide: Bool
}

struct AddRating: Codable{
    let rate: Int32
    let user: String
}

struct AddUserLike: Codable{
    let email: String?
}

struct UserAPIModelPagination: Codable{
    var page, count: Int32
    let data: [UserAPIModel]?
}

struct GuideInformationAPI: Codable{
    let name: String?
    let photo: PhotoAPIModel
    let tourCount, likes: Int32
    let city: String?
}

struct GuideInformationAPIPagination: Codable {
    var page, count: Int32
    let data: [GuideInformationAPI]?
}

struct FindTourAPI: Codable{
    let search: String
    var page, count: Int32
}

struct UserTours: Codable{
    var page, count: Int32
}

struct StreamingModel: Codable{
    var page, count: Int32
}

public struct CodableImage: Codable {
    public let photo: Data
    public init(photo: UIImage) {
        self.photo = photo.pngData()!
    }
//    Deserialize example:
//    UIImage(data: instanceOfSomeImage.photo)!
}
