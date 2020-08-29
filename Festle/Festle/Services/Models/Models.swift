//
//  Models.swift
//  Festle
//
//  Created by Евгений Уланов on 26.08.2020.
//  Copyright © 2020 Евгений Уланов. All rights reserved.
//

import Foundation

struct LoginModel: Codable{
    let login, password, platform: String
}

struct LoginResult {
    let accessToken, refreshToken: String
}

struct LoginModelByExternalApi{
    let key, name, platform: String
}

struct RegisterModel: Codable{
    let email, nickname, password, platform: String
}

struct RegisterModelByExternalAPI{
    let email, nickname, platform, externalId, externalName: String
}

struct CreateTourPoint{
    let name, descriptio: String
    let location, address : String?
    let isAutoGenerate: Bool
    let pointNumber: Int32
}

struct CreateTour{
    let name, dateTime, description: String
    let isDraft: Bool
    let price: Double
    let length: Float
    let createTourPoints: [CreateTourPoint]
}

struct RoleAPIModel{
    let name: String
}

struct PhotoAPIModel{
    let fileName, id: String?
}

struct UserAPIModel{
    let email, nickname, city, phone, about: String?
    let isGuide: Bool
    let rating: Float
    let role: RoleAPIModel
    let photo: PhotoAPIModel
}

struct TourPointAPIModel {
    let id: Int32
    let name, description, coords: String?
    let pointNumber: Int32
    let photos: [PhotoAPIModel]?
}

struct TourAPIModel{
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

struct TourAPIModelPagination{
    let page, count: Int32
    let data: TourAPIModel?
}

struct UpdateTourPoint{
    let id, pointNumber: Int32
    let name, description: String
    let isAutoGenerate: Bool
    let location, address: String?
}

struct UpdateTour{
    let id: Int32
    let name, dateTime, description: String
    let isDraft, isGenerateTourPoint: Bool
    let price: Double
    let length: Float
    let updateTourPoints: [UpdateTourPoint]?
}

struct AddPointToTour{
    let name, description: String
    let isAutoGenerate: Bool
    let location, address: String?
    let tourId, pointNumber: Int32
}

struct EndTourEdit{
    let id: Int32
}

struct RemoveTourPhoto{
    let photoId: String?
}

struct PasswordRestore{
    let password, prevPassword: String
}

struct ChangeUser{
    let nickname, email: String
    let isGuide: Bool
}

struct AddRating{
    let rate: Int32
    let user: String
}

struct AddUserLike{
    let email: String?
}

struct UserAPIModelPagination{
    let page, count: Int32
    let data: [UserAPIModel]?
}

struct GuideInformationAPI{
    let name: String?
    let photo: PhotoAPIModel
    let tourCount, likes: Int32
    let city: String?
}

struct GuideInformationAPIPagination {
    let page, count: Int32
    let data: [GuideInformationAPI]?
}
