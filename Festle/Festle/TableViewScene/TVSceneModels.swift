//
//  TVSceneModels.swift
//  Festle
//
//  Created by Евгений Уланов on 03.08.2020.
//  Copyright (c) 2020 Евгений Уланов. All rights reserved.
//

import UIKit

enum TVScene {
   
  enum Model {
    struct Request {
      enum RequestType {
        case some
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
  
    enum SceneType{
        case Guids
        case Fests
        case Search
    }
}
