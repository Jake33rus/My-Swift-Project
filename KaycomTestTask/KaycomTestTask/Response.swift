//
//  Response.swift
//  KaycomTestTask
//
//  Created by Евгений Уланов on 15.09.2020.
//  Copyright © 2020 Евгений Уланов. All rights reserved.
//

import Foundation
// MARK: - GiftCards
struct GiftCards: Codable {
    let providers: [Provider]
}

// MARK: - Provider
struct Provider: Codable {
    let id: Int
    let title: String
    let imageURL: String
    let giftCards: [GiftCard]

    enum CodingKeys: String, CodingKey {
        case id, title
        case imageURL = "image_url"
        case giftCards = "gift_cards"
    }
}

// MARK: - GiftCard
struct GiftCard: Codable {
    let id: Int
    let featured: Bool
    let title: String
    let credits: Int
    let imageURL: String
    let codesCount: Int
    let currency, giftCardDescription: String
    let redeemURL: String

    enum CodingKeys: String, CodingKey {
        case id, featured, title, credits
        case imageURL = "image_url"
        case codesCount = "codes_count"
        case currency
        case giftCardDescription = "description"
        case redeemURL = "redeem_url"
    }
}
