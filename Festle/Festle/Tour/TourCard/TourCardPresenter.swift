//
//  TourCardPresenter.swift
//  Festle
//
//  Created by Евгений Уланов on 23.08.2020.
//  Copyright (c) 2020 Евгений Уланов. All rights reserved.
//

import UIKit

protocol TourCardPresentationLogic {
  func presentData(response: TourCard.Model.Response.ResponseType)
}

class TourCardPresenter: TourCardPresentationLogic {
  weak var viewController: TourCardDisplayLogic?
  
  func presentData(response: TourCard.Model.Response.ResponseType) {
  
  }
  
}
