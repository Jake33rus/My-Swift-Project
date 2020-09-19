//
//  RequestModels.swift
//  Festle
//
//  Created by Евгений Уланов on 06.09.2020.
//  Copyright © 2020 Евгений Уланов. All rights reserved.
//

import Foundation

struct ChangeUserRequest: Codable {
    let nickname, email: String
    let isGuide: Bool
    let city, phone, about, applicationLanguage: String
    let voiceLanguage: String
    let sex: Int
}
