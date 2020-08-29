//
//  FavoritePresenter.swift
//  Festle
//
//  Created by Евгений Уланов on 12.07.2020.
//  Copyright (c) 2020 Евгений Уланов. All rights reserved.
//

import UIKit

protocol FavoritePresentationLogic {
  func presentData(response: Favorite.Model.Response.ResponseType)
}

class FavoritePresenter: FavoritePresentationLogic {
  weak var viewController: FavoriteDisplayLogic?
  
  func presentData(response: Favorite.Model.Response.ResponseType) {
  
  }
  
}
