//
//  ProfileInteractor.swift
//  Festle
//
//  Created by Евгений Уланов on 12.07.2020.
//  Copyright (c) 2020 Евгений Уланов. All rights reserved.
//

import UIKit

protocol ProfileBusinessLogic {
  func makeRequest(request: UserProfile.Model.Request.RequestType)
}

class ProfileInteractor: ProfileBusinessLogic {

  var presenter: ProfilePresentationLogic?
  var service: ProfileService?
  
  func makeRequest(request: UserProfile.Model.Request.RequestType) {
    if service == nil {
      service = ProfileService()
    }
  }
  
}
