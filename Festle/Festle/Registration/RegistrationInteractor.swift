//
//  RegistrationInteractor.swift
//  Festle
//
//  Created by Евгений Уланов on 26.07.2020.
//  Copyright (c) 2020 Евгений Уланов. All rights reserved.
//

import UIKit

protocol RegistrationBusinessLogic {
  func makeRequest(request: Registration.Model.Request.RequestType)
}

class RegistrationInteractor: RegistrationBusinessLogic {

  var presenter: RegistrationPresentationLogic?
  var service: RegistrationService?
    
  func makeRequest(request: Registration.Model.Request.RequestType) {
    if service == nil {
      service = RegistrationService()
    }
    switch request {
    case .VkRegistration:
        print("vk")
    case .FacebookRegistration:
        print("facebook")
    case .Registration(model: let model):
        print("")
        }
    }
}
