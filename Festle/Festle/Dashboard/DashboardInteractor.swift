//
//  DashboardInteractor.swift
//  Festle
//
//  Created by Евгений Уланов on 12.07.2020.
//  Copyright (c) 2020 Евгений Уланов. All rights reserved.
//

import UIKit

protocol DashboardBusinessLogic {
  func makeRequest(request: Dashboard.Model.Request.RequestType)
  func logoutPress() -> Bool
}

class DashboardInteractor: DashboardBusinessLogic {
    func logoutPress() -> Bool {
        return TokenService.shared.removeAccessToken() && TokenService.shared.removeRefreshToken()
    }

  var presenter: DashboardPresentationLogic?
  var service: DashboardService?
  
  func makeRequest(request: Dashboard.Model.Request.RequestType) {
    if service == nil {
      service = DashboardService()
    }
  }
  
}
