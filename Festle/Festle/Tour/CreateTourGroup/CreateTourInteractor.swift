//
//  CreateTourInteractor.swift
//  Festle
//
//  Created by Евгений Уланов on 23.08.2020.
//  Copyright (c) 2020 Евгений Уланов. All rights reserved.
//

import UIKit

protocol CreateTourBusinessLogic {
  func makeRequest(request: CreateTourModels.Model.Request.RequestType)
}

class CreateTourInteractor: CreateTourBusinessLogic {

  var presenter: CreateTourPresentationLogic?
  var service: CreateTourService?
  
  func makeRequest(request: CreateTourModels.Model.Request.RequestType) {
    if service == nil {
      service = CreateTourService()
    }
  }
  
}
