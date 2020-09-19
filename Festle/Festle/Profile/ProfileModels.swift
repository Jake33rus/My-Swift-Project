//
//  ProfileModels.swift
//  Festle
//
//  Created by Евгений Уланов on 12.07.2020.
//  Copyright (c) 2020 Евгений Уланов. All rights reserved.
//

import UIKit

enum UserProfile {
   
  enum Model {
    struct Request {
      enum RequestType {
        case getUser
      }
    }
    struct Response {
      enum ResponseType {
        case presentUserInfo(userInfo: DatumUser)
      }
    }
    struct ViewModel {
      enum ViewModelData {
        case displayUserInfo(userInfo: DatumUser)
      }
    }
  }
  
}

struct UserInfoViewModel{
    let isGuide: Bool
    let name: String
    let photo: UIImage?
    let photoURL: String?
    let phone: String?
    let lang: String?
    let email: String
    let about: String?
    let city: String?
    var contact: String {
        get{
            return "\(phone)\n\(email)"
        }
    }
}
