//
//  FavoriteInteractor.swift
//  Festle
//
//  Created by Евгений Уланов on 12.07.2020.
//  Copyright (c) 2020 Евгений Уланов. All rights reserved.
//

import UIKit

protocol FavoriteBusinessLogic {
  func makeRequest(request: Favorite.Model.Request.RequestType)
}

class FavoriteInteractor: FavoriteBusinessLogic {

  var presenter: FavoritePresentationLogic?
  var service: FavoriteService?
  
  func makeRequest(request: Favorite.Model.Request.RequestType) {
    if service == nil {
      service = FavoriteService()
    }
  }
  
}
