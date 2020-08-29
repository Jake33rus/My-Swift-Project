//
//  LoginModels.swift
//  Festle
//
//  Created by Евгений Уланов on 05.07.2020.
//  Copyright (c) 2020 Евгений Уланов. All rights reserved.
//

import UIKit

enum Login {
   
  enum Model {
    struct Request {
      enum RequestType {
        case baseLogIn(model: LoginModel)
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

struct AuthModel{
    var login:String
    var password:String
    var platform: String = "iOS"
}
