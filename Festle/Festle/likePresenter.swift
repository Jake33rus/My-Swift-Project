//
//  likePresenter.swift
//  Festle
//
//  Created by Евгений Уланов on 12.07.2020.
//  Copyright (c) 2020 Евгений Уланов. All rights reserved.
//

import UIKit

protocol likePresentationLogic {
  func presentData(response: like.Model.Response.ResponseType)
}

class likePresenter: likePresentationLogic {
  weak var viewController: likeDisplayLogic?
  
  func presentData(response: like.Model.Response.ResponseType) {
  
  }
  
}
