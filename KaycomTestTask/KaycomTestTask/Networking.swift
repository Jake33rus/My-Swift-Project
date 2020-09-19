//
//  Networking.swift
//  KaycomTestTask
//
//  Created by Евгений Уланов on 15.09.2020.
//  Copyright © 2020 Евгений Уланов. All rights reserved.
//

import Foundation

class Networking: NSObject, URLSessionDelegate{
    
    override init() {
        super.init()
        let url = URL(string: "http://digipeople.ru/_test/providers.json")
        let session = URLSession(configuration: URLSessionConfiguration.default, delegate: self, delegateQueue: nil)
    }
    
    public func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
       //Trust the certificate even if not valid
       let urlCredential = URLCredential(trust: challenge.protectionSpace.serverTrust!)

       completionHandler(.useCredential, urlCredential)
    }
}
