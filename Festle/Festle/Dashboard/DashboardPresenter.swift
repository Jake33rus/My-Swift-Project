//
//  DashboardPresenter.swift
//  Festle
//
//  Created by Евгений Уланов on 12.07.2020.
//  Copyright (c) 2020 Евгений Уланов. All rights reserved.
//

import UIKit

protocol DashboardPresentationLogic {
  func presentData(response: Dashboard.Model.Response.ResponseType)
}

class DashboardPresenter: DashboardPresentationLogic {
  weak var viewController: DashboardDisplayLogic?
  
  func presentData(response: Dashboard.Model.Response.ResponseType) {
  
  }
  
}
