//
//  GuideCardRouter.swift
//  Festle
//
//  Created by Евгений Уланов on 16.08.2020.
//  Copyright (c) 2020 Евгений Уланов. All rights reserved.
//

import UIKit

protocol GuideCardRoutingLogic {
    func prepare(for segue:UIStoryboardSegue, sender: Any?)
}

class GuideCardRouter: NSObject, GuideCardRoutingLogic {
    func prepare(for segue: UIStoryboardSegue, sender: Any?) {

    }
    

  weak var viewController: GuideCardViewController?
  
  // MARK: Routing
  
}
