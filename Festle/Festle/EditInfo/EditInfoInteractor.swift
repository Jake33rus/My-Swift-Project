//
//  EditInfoInteractor.swift
//  Festle
//
//  Created by Евгений Уланов on 02.08.2020.
//  Copyright (c) 2020 Евгений Уланов. All rights reserved.
//

import UIKit

protocol EditInfoBusinessLogic {
  func makeRequest(request: EditInfo.Model.Request.RequestType)
}

class EditInfoInteractor: EditInfoBusinessLogic {

  var presenter: EditInfoPresentationLogic?
  var service: EditInfoService?
  
  func makeRequest(request: EditInfo.Model.Request.RequestType) {
    if service == nil {
      service = EditInfoService()
    }
  }
  
}
