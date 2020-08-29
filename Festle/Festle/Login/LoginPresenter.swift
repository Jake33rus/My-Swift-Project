//
//  LoginPresenter.swift
//  Festle
//
//  Created by Евгений Уланов on 05.07.2020.
//  Copyright (c) 2020 Евгений Уланов. All rights reserved.
//

import UIKit

protocol LoginPresentationLogic {
  func presentData(response: Login.Model.Response.ResponseType)
}

class LoginPresenter: LoginPresentationLogic {
  weak var viewController: LoginDisplayLogic?
  
  func presentData(response: Login.Model.Response.ResponseType) {
  
  }
  
}
