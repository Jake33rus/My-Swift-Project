//
//  CreateTourPresenter.swift
//  Festle
//
//  Created by Евгений Уланов on 23.08.2020.
//  Copyright (c) 2020 Евгений Уланов. All rights reserved.
//

import UIKit

protocol CreateTourPresentationLogic {
  func presentData(response: CreateTourModels.Model.Response.ResponseType)
}

class CreateTourPresenter: CreateTourPresentationLogic {
  weak var viewController: CreateTourDisplayLogic?
  
  func presentData(response: CreateTourModels.Model.Response.ResponseType) {
  
  }
  
}
