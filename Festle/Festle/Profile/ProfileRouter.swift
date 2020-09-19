//
//  ProfileRouter.swift
//  Festle
//
//  Created by Евгений Уланов on 12.07.2020.
//  Copyright (c) 2020 Евгений Уланов. All rights reserved.
//

import UIKit

protocol ProfileRoutingLogic {
    func showEditInfoScene()
    func showSettingScene()
    func prepare(for segue:UIStoryboardSegue, sender: Any?)
}

class ProfileRouter: NSObject, ProfileRoutingLogic {
    func showSettingScene() {
        viewController?.performSegue(withIdentifier: viewController!.selfToSettinfSegueName, sender: nil)
    }
    
    func showEditInfoScene() {
        viewController?.performSegue(withIdentifier: viewController!.selfToEditInfoSegueName, sender: nil)
    }
    
    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == viewController?.selfToEditInfoSegueName){
            let destination = segue.destination as? EditInfoViewController
            let userInfo = viewController?.userInfoVM
            destination?.userInfo = userInfo
        }
    }
    

  weak var viewController: ProfileViewController?
  
  // MARK: Routing
  
}
