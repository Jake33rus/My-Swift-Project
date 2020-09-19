//
//  EditInfoInteractor.swift
//  Festle
//
//  Created by Евгений Уланов on 02.08.2020.
//  Copyright (c) 2020 Евгений Уланов. All rights reserved.
//

import UIKit

protocol EditInfoBusinessLogic {
  func makeRequest(request: EditInfo.Model.Request.RequestType)
}

class EditInfoInteractor: EditInfoBusinessLogic {

  var presenter: EditInfoPresentationLogic?
  var service: EditInfoService?
  private var fetcher = NetworkFetcher()
  
  func makeRequest(request: EditInfo.Model.Request.RequestType) {
    switch request {
    case .updatePhoto(nick: let nick, photo: let photo):
        fetcher.tourFetcher.requestPhoto(username: nick, image: photo) { (result) in
            switch result{
            case .success(_):
                self.presenter?.presentData(response: .presentInfoForUpdate(info: "SUCCESS"))
            case .failure(_):
                self.presenter?.presentData(response: .presentInfoForUpdate(info: "ERROR"))
            }
        }
    case .saveNewInfo(model: let model):
        fetcher.userFetcher.request(service: .changeUser(model: model), decodeType: CodeRequest.self) { (result) in
            switch (result){
            case .success(_):
                self.presenter?.presentData(response: .presentInfoForUpdate(info: "SUCCESS"))
            case .failure(_):
                self.presenter?.presentData(response: .presentInfoForUpdate(info: "ERROR"))
            }
        }
    }
    
  }
  
}
