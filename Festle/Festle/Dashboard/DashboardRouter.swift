//
//  DashboardRouter.swift
//  Festle
//
//  Created by Евгений Уланов on 12.07.2020.
//  Copyright (c) 2020 Евгений Уланов. All rights reserved.
//

import UIKit

protocol DashboardRoutingLogic {
    func prepare(for segue:UIStoryboardSegue, sender: Any?)
}

class DashboardRouter: NSObject, DashboardRoutingLogic {
    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? TVSceneViewController else {return}
        if segue.identifier == viewController!.selfToMoreGuidsSegueName {
            destination.sceneType = .Guids
        }
        else if segue.identifier == viewController!.selfToMoreFestsSegueName{
            destination.sceneType = .Fests
        }
        else if segue.identifier == viewController!.selfToMoreGuidInfoSegueName{
            viewController?.performSegue(withIdentifier: viewController!.selfToMoreGuidInfoSegueName, sender: nil)
        }
        else if segue.identifier == viewController!.selfToMoreTourInfoSegueName{
            viewController?.performSegue(withIdentifier: viewController!.selfToMoreTourInfoSegueName, sender: nil)
        }
        else {
            destination.sceneType = .Search
        }
    }
    

  weak var viewController: DashboardViewController?
  
  // MARK: Routing
  
}
