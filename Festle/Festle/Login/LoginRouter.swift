//
//  LoginRouter.swift
//  Festle
//
//  Created by Евгений Уланов on 05.07.2020.
//  Copyright (c) 2020 Евгений Уланов. All rights reserved.
//

import UIKit

protocol LoginRoutingLogic {
    func showRegistrationScene()
    func showMainScene()
    func prepare(for segue: UIStoryboardSegue, sender: Any?)
}

class LoginRouter: NSObject, LoginRoutingLogic {

  weak var viewController: LoginViewController?
  
  // MARK: Routing
    func showRegistrationScene(){
        viewController?.performSegue(withIdentifier: viewController!.selfToRegistrationSegueName, sender: nil)
    }
    
    func showMainScene(){
        viewController?.performSegue(withIdentifier: viewController!.selfToMainSegueName, sender: nil)
    }
    
    func prepare(for segue: UIStoryboardSegue, sender: Any?){
        
    }
}
