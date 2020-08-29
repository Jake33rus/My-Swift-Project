//
//  ProfilePresenter.swift
//  Festle
//
//  Created by Евгений Уланов on 12.07.2020.
//  Copyright (c) 2020 Евгений Уланов. All rights reserved.
//

import UIKit

protocol ProfilePresentationLogic {
  func presentData(response: UserProfile.Model.Response.ResponseType)
}

class ProfilePresenter: ProfilePresentationLogic {
  weak var viewController: ProfileDisplayLogic?
  
  func presentData(response: UserProfile.Model.Response.ResponseType) {
  
  }
  
}
