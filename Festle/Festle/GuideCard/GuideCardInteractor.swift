//
//  GuideCardInteractor.swift
//  Festle
//
//  Created by Евгений Уланов on 16.08.2020.
//  Copyright (c) 2020 Евгений Уланов. All rights reserved.
//

import UIKit

protocol GuideCardBusinessLogic {
  func makeRequest(request: GuideCard.Model.Request.RequestType)
}

class GuideCardInteractor: GuideCardBusinessLogic {

  var presenter: GuideCardPresentationLogic?
  var service: GuideCardService?
  
  func makeRequest(request: GuideCard.Model.Request.RequestType) {
    if service == nil {
      service = GuideCardService()
    }
  }
  
}
