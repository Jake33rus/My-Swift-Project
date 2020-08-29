//
//  TourCardInteractor.swift
//  Festle
//
//  Created by Евгений Уланов on 23.08.2020.
//  Copyright (c) 2020 Евгений Уланов. All rights reserved.
//

import UIKit

protocol TourCardBusinessLogic {
  func makeRequest(request: TourCard.Model.Request.RequestType)
}

class TourCardInteractor: TourCardBusinessLogic {

  var presenter: TourCardPresentationLogic?
  var service: TourCardService?
  
  func makeRequest(request: TourCard.Model.Request.RequestType) {
    if service == nil {
      service = TourCardService()
    }
  }
  
}
