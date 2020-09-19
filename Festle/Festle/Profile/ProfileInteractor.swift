//
//  ProfileInteractor.swift
//  Festle
//
//  Created by Евгений Уланов on 12.07.2020.
//  Copyright (c) 2020 Евгений Уланов. All rights reserved.
//

import UIKit

protocol ProfileBusinessLogic {
  func makeRequest(request: UserProfile.Model.Request.RequestType)
}

class ProfileInteractor: ProfileBusinessLogic {

    var presenter: ProfilePresentationLogic?
    var service: ProfileService?
    private var fetcher = NetworkFetcher()
    private var userData: DatumUser?
  
  func makeRequest(request: UserProfile.Model.Request.RequestType) {
//    if service == nil {
//      service = ProfileService()
//    }
    switch request {
    case .getUser:
        fetcher.userFetcher.request(service: .getUser, decodeType: DatumUser.self) {[weak self] (response) in
            switch(response){
            case .success(let result):
                self?.userData = result
                self?.presentUser()
            case .failure(let error):
                self?.userData = nil
                print("Get User Error: \n,\(error.localizedDescription)")
            }
        }
    }
  }
  func presentUser(){
         guard let userData = userData else { return }
        presenter?.presentData(response: .presentUserInfo(userInfo: userData))
     }
}
