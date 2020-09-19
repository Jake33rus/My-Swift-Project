//
//  EditInfoModels.swift
//  Festle
//
//  Created by Евгений Уланов on 02.08.2020.
//  Copyright (c) 2020 Евгений Уланов. All rights reserved.
//

import UIKit

enum EditInfo {
   
  enum Model {
    struct Request {
      enum RequestType {
        case updatePhoto(nick:String, photo: UIImage)
        case saveNewInfo(model: ChangeUserRequest)
      }
    }
    struct Response {
      enum ResponseType {
        case presentInfoForUpdate(info: String)
      }
    }
    struct ViewModel {
      enum ViewModelData {
        case displaySuccessUpdate(info: String)
      }
    }
  }
}

struct EditInfoModel{
    var image: String?
    var firstName: String?
    var secondName: String?
    var city: String?
    var email: String?
    var tel: String?
    var languages: String?
    var birthDayDate: String?
    var aboutUser: String?
}
