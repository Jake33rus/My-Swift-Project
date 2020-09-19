//
//  AccessTokenService.swift
//  Festle
//
//  Created by Евгений Уланов on 27.08.2020.
//  Copyright © 2020 Евгений Уланов. All rights reserved.
//

import Foundation
import SwiftKeychainWrapper

class TokenService{
    
    private var accessKey = "AccessToken"
    private var refreshKey = "RefreshToken"
    
    static var shared: TokenService = {
        let instance = TokenService()
        return instance
    }()
    
    private init() {}
    
    func addTokens(tokens: AuthResponse)->Bool{
        let saveAccessSuccessful: Bool = KeychainWrapper.standard.set(tokens.accessToken, forKey: accessKey)
        let saveRefreshSuccessful: Bool = KeychainWrapper.standard.set(tokens.refreshToken, forKey: refreshKey)
        return saveAccessSuccessful && saveRefreshSuccessful
    }
    
    func getAccessToken() -> String?{
        return KeychainWrapper.standard.string(forKey: accessKey)
    }
    
    func getRefreshToken() -> String?{
        return KeychainWrapper.standard.string(forKey: refreshKey)
    }
    
    func removeAccessToken() -> Bool{
        return KeychainWrapper.standard.removeObject(forKey: accessKey)
    }
    
    func removeRefreshToken() -> Bool{
        return KeychainWrapper.standard.removeObject(forKey: refreshKey)
    }
    
    func updateTokens(model: AuthResponse)->Bool{
        if(removeAccessToken() && removeRefreshToken())
        {
            return addTokens(tokens: model)
        }
        return false
    }
}

extension TokenService: NSCopying {
    func copy(with zone: NSZone? = nil) -> Any {
        return self
    }
}
