//
//  ViewController.swift
//  KaycomTestTask
//
//  Created by Евгений Уланов on 15.09.2020.
//  Copyright © 2020 Евгений Уланов. All rights reserved.
//

import UIKit

class ViewController: UIViewController  {

    var providers: [Provider] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
    }

    func getData(){
        let session = URLSession(configuration: URLSessionConfiguration.default, delegate: self, delegateQueue: nil)
        let url = URL(string: "http://digipeople.ru/_test/providers.json")!
        
        let task = session.dataTask(with: url) {[weak self] data, response, error in

            if error != nil || data == nil {
                print("Client error!")
                return
            }

            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                print("Server error!")
                return
            }

            guard let mime = response.mimeType, mime == "application/json" else {
                print("Wrong MIME type!")
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
                let giftCards = try decoder.decode(GiftCards.self, from: data!)
                self!.providers = giftCards.providers
            } catch {
                print("Serilization error: \(error.localizedDescription)")
            }
        }
        task.resume()
    }

}

extension ViewController:URLSessionDelegate{
    public func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
          //Trust the certificate even if not valid
          let urlCredential = URLCredential(trust: challenge.protectionSpace.serverTrust!)
          completionHandler(.useCredential, urlCredential)
       }
}

