//
//  ResponseModels.swift
//  Festle
//
//  Created by Евгений Уланов on 26.07.2020.
//  Copyright © 2020 Евгений Уланов. All rights reserved.
//

import Foundation
import Alamofire

// MARK: - Login, Registration, ChangePassword - AuthResponse
struct AuthResponse: Codable {
    let accessToken, refreshToken: String
}

// MARK: - CreateTourResponse and UpdateTourResponse
struct TourResponse: Codable {
    let id: Int
    let name, TourResponseDescription, dateTime: String
    let guide: GuideResponse
    let isDraft: Bool
    let price: Int
    let isFree: Bool
    let tourPoints: [TourPointResponse]
    let photos: [PhotoResponse]
    let length, likeCount: Int

    enum CodingKeys: String, CodingKey {
        case id, name
        case TourResponseDescription = "description"
        case dateTime, guide, isDraft, price, isFree, tourPoints, photos, length, likeCount
    }
}

// MARK: - Guide
struct GuideResponse: Codable {
    let email, nickname: String?
    let isGuide: Bool
    let city, phone, about: String?
    let likeCount: Int
    let role: RoleResponse
    let photo: PhotoResponse?
}

// MARK: - Photo
struct PhotoResponse: Codable {
    let fileName, id: String
}

// MARK: - Role
struct RoleResponse: Codable {
    let name: String
}

// MARK: - TourPoint
struct TourPointResponse: Codable {
    let id: Int
    let name, description, coords: String
    let pointNumber: Int
    let photos: [PhotoResponse]
}

// MARK: - FindTourResponse
struct FindTourResponse: Codable {
    let page, count: Int
    let data: [DatumResponse]
}

// MARK: - Datum
struct DatumResponse: Codable {
    let id: Int
    let name, description, dateTime: String
    let guide: GuideResponse
    let isDraft: Bool
    let price: Int
    let isFree: Bool
    let tourPoints: [TourPointResponse]
    let photos: [PhotoResponse]
    let length, likeCount: Int
}

// MARK: - UserResponse
struct UserResponse: Codable {
    let email, nickname: String?
    let isGuide: Bool?
    let likeCount: Int?
    let city, phone, about: String?
    let role: RoleResponse?
    let photo: PhotoResponse?
}

// MARK: - FindUserResponse
struct FindUserResponse: Codable {
    let page, count: Int
    let data: [DatumUser]
}

// MARK: - Datum
struct DatumUser: Codable {
    let email, nickname: String
    let isGuide: Bool
    let city, phone, about: String?
    let likeCount: Int32
    let role: RoleResponse
    let photo: PhotoResponse?
}

// MARK: - TopGuideResponse
struct TopGuideResponse: Codable {
    let page, pagesCount, count: Int32
    let data: [DatumTopGuid]
}

// MARK: - Datum
struct DatumTopGuid: Codable {
    let name: String
    let photo: PhotoResponse?
    let tourCount, likesCount: Int32
    let city, email: String
}

struct OnlineNowResponse: Codable {
    let page, count: Int
    let data: [DatumOnline]
}

// MARK: - Datum
struct DatumOnline: Codable {
    let id: Int
    let name, datumDescription, dateTime: String
    let guide: Guide
    let isDraft: Bool
    let price: Int
    let isFree: Bool
    let tourPoints: [TourPointResponse]
    let photos: [Photo]
    let length, likeCount: Int

    enum CodingKeys: String, CodingKey {
        case id, name
        case datumDescription = "description"
        case dateTime, guide, isDraft, price, isFree, tourPoints, photos, length, likeCount
    }
}

// MARK: - Guide
struct Guide: Codable {
    let email, nickname: String
    let isGuide: Bool
    let rating: Int
    let city, phone, about: String
    let role: Role
    let photo: Photo
}

// MARK: - Photo
struct Photo: Codable {
    let fileName, id: String
}

// MARK: - Role
struct Role: Codable {
    let name: String
}

struct FreshTourResponse: Codable {
    let page, pagesCount, count: Int
    let data: [FreshTourDatum]
}

// MARK: - Datum
struct FreshTourDatum: Codable {
    let id: Int
    let name, description, dateTime: String
    let guide: GuideResponse
    let isDraft: Bool
    let price: Int
    let isFree: Bool
    let tourPoints: [TourPointResponse]
    let photos: [Photo]
    let length, likeCount: Int
    let isSpended: Bool
}

struct CodeRequest: Codable{
    
}
