//
//  AuthService.swift
//  NewsFeedVK
//
//  Created by Евгений Уланов on 04.06.2020.
//  Copyright © 2020 Евгений Уланов. All rights reserved.
//

import Foundation
import VKSdkFramework

protocol AuthServiceDelegate: class{
    func authServiceShouldShow(viewController: UIViewController)
    func authServiceSingIn()
    func authServiceSingInDidFail()
}

class AuthService: NSObject, VKSdkDelegate, VKSdkUIDelegate {
    
    private let appId = "7498936"
    private let vkSdk: VKSdk
    
    override init() {
        vkSdk = VKSdk.initialize(withAppId: appId)
        super.init()
        print("VKSdk initialize")
        vkSdk.register(self)
        vkSdk.uiDelegate = self
    }
    
    weak var delegate: AuthServiceDelegate?
    
    var token: String? {
        return VKSdk.accessToken()?.accessToken
    }
    
    func wakeUpSession(){
        let scope = ["wall","friends"]
        VKSdk.wakeUpSession(scope) { [delegate] (state, error) in
            switch state {
                case .initialized:
                    print("initialized")
                    VKSdk.authorize(scope)
                case .authorized:
                    print("authorized")
                    delegate?.authServiceSingIn()
                default:
                    delegate?.authServiceSingInDidFail()
            }
        }
    }
    
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        if result.token != nil {
            delegate?.authServiceSingIn()
        }
    }
    
    func vkSdkUserAuthorizationFailed() {
        print(#function)
        delegate?.authServiceSingInDidFail()
    }
    
    func vkSdkShouldPresent(_ controller: UIViewController!) {
        print(#function)
        delegate?.authServiceShouldShow(viewController: controller)
    }
    
    func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {
        print(#function)
    }
}
