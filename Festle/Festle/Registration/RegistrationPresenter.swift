//
//  RegistrationPresenter.swift
//  Festle
//
//  Created by Евгений Уланов on 26.07.2020.
//  Copyright (c) 2020 Евгений Уланов. All rights reserved.
//

import UIKit

protocol RegistrationPresentationLogic {
  func presentData(response: Registration.Model.Response.ResponseType)
}

class RegistrationPresenter: RegistrationPresentationLogic {
  weak var viewController: RegistrationDisplayLogic?
  
  func presentData(response: Registration.Model.Response.ResponseType) {
  
  }
  
}
