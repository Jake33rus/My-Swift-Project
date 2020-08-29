//
//  LoginInteractor.swift
//  Festle
//
//  Created by Евгений Уланов on 05.07.2020.
//  Copyright (c) 2020 Евгений Уланов. All rights reserved.
//

import UIKit
import FBSDKLoginKit

protocol LoginBusinessLogic {
    func makeRequest(request: Login.Model.Request.RequestType)
    func authFacebook(loginVC: LoginViewController)
}

class LoginInteractor: LoginBusinessLogic {
    func authFacebook(loginVC: LoginViewController) {
        let loginManager = LoginManager()
        if let _ = AccessToken.current {
            loginManager.logOut()
        } else {
            loginManager.logIn(permissions: [], from: loginVC) { [weak loginVC] (result, error) in
                guard error == nil else {                    print(error!.localizedDescription)
                    return
                }
                guard let result = result, !result.isCancelled else {
                    print("User cancelled login")
                    return
                }
                Profile.loadCurrentProfile { (profile, error) in
                    print(Profile.current?.name as Any)
                }
        }
    }
    }
    

  var presenter: LoginPresentationLogic?
  var authResponse: AuthResponse?
  func makeRequest(request: Login.Model.Request.RequestType) {
        switch request {
        case .baseLogIn(model: let model):
            let loginProvider = NetworkManager<LoginProvider>()
            loginProvider.request(service: .login(loginModel: model), decodeType: (AuthResponse.self)) { (result) in
                switch result{
                case .success(let response):
                    let addTokensResult = TokenService.shared.addTokens(tokens: response)
                    print("Success, add token in KeyChain")
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}
