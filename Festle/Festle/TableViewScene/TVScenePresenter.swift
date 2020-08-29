//
//  TVScenePresenter.swift
//  Festle
//
//  Created by Евгений Уланов on 03.08.2020.
//  Copyright (c) 2020 Евгений Уланов. All rights reserved.
//

import UIKit

protocol TVScenePresentationLogic {
  func presentData(response: TVScene.Model.Response.ResponseType)
}

class TVScenePresenter: TVScenePresentationLogic {
  weak var viewController: TVSceneDisplayLogic?
  
  func presentData(response: TVScene.Model.Response.ResponseType) {
  
  }
  
}
