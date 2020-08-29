//
//  RegistrationModels.swift
//  Festle
//
//  Created by Евгений Уланов on 26.07.2020.
//  Copyright (c) 2020 Евгений Уланов. All rights reserved.
//

import UIKit

enum Registration {
   
  enum Model {
    struct Request {
      enum RequestType {
        case VkRegistration
        case FacebookRegistration
        case Registration(model: RegistrationModel)
      }
    }
    struct Response {
      enum ResponseType {
        case some
      }
    }
    struct ViewModel {
      enum ViewModelData {
        case some
      }
    }
  }
}

struct RegistrationModel{
    var email: String
    var nickname: String
    var password: String
    var platform: String = "iOS"
}


