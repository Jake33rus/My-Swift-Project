//
//  GuideCardPresenter.swift
//  Festle
//
//  Created by Евгений Уланов on 16.08.2020.
//  Copyright (c) 2020 Евгений Уланов. All rights reserved.
//

import UIKit

protocol GuideCardPresentationLogic {
  func presentData(response: GuideCard.Model.Response.ResponseType)
}

class GuideCardPresenter: GuideCardPresentationLogic {
  weak var viewController: GuideCardDisplayLogic?
  
  func presentData(response: GuideCard.Model.Response.ResponseType) {
  
  }
  
}
