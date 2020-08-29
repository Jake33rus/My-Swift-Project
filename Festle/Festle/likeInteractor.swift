//
//  likeInteractor.swift
//  Festle
//
//  Created by Евгений Уланов on 12.07.2020.
//  Copyright (c) 2020 Евгений Уланов. All rights reserved.
//

import UIKit

protocol likeBusinessLogic {
  func makeRequest(request: like.Model.Request.RequestType)
}

class likeInteractor: likeBusinessLogic {

  var presenter: likePresentationLogic?
  var service: likeService?
  
  func makeRequest(request: like.Model.Request.RequestType) {
    if service == nil {
      service = likeService()
    }
  }
  
}
