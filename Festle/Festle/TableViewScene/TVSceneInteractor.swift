//
//  TVSceneInteractor.swift
//  Festle
//
//  Created by Евгений Уланов on 03.08.2020.
//  Copyright (c) 2020 Евгений Уланов. All rights reserved.
//

import UIKit

protocol TVSceneBusinessLogic {
  func makeRequest(request: TVScene.Model.Request.RequestType)
}

class TVSceneInteractor: TVSceneBusinessLogic {

  var presenter: TVScenePresentationLogic?
  var service: TVSceneService?
  
  func makeRequest(request: TVScene.Model.Request.RequestType) {
    if service == nil {
      service = TVSceneService()
    }
  }
  
}
