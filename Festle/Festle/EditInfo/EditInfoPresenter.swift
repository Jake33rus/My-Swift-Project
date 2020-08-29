//
//  EditInfoPresenter.swift
//  Festle
//
//  Created by Евгений Уланов on 02.08.2020.
//  Copyright (c) 2020 Евгений Уланов. All rights reserved.
//

import UIKit

protocol EditInfoPresentationLogic {
  func presentData(response: EditInfo.Model.Response.ResponseType)
}

class EditInfoPresenter: EditInfoPresentationLogic {
  weak var viewController: EditInfoDisplayLogic?
  
  func presentData(response: EditInfo.Model.Response.ResponseType) {
  
  }
  
}
