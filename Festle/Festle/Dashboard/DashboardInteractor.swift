//
//  DashboardInteractor.swift
//  Festle
//
//  Created by Евгений Уланов on 12.07.2020.
//  Copyright (c) 2020 Евгений Уланов. All rights reserved.
//

import UIKit

protocol DashboardBusinessLogic {
  func makeRequest(request: Dashboard.Model.Request.RequestType)
  func logoutPress() -> Bool
}

class DashboardInteractor: DashboardBusinessLogic {
    func logoutPress() -> Bool {
//            fetcher.loginFetcher.request(service: .logout(authorization: TokenService.shared.getAccessToken()!), decodeType: AuthResponse.self) { [weak self] (response) in
//                switch(response){
//                case .success(_):
//                    self?.isLogout = true
//                case .failure(let error):
//                    print("Logout Error: \n \(error.localizedDescription)")
//                    self?.isLogout = false
//                }
//            }
//        if (isLogout){
            if (TokenService.shared.removeAccessToken() && TokenService.shared.removeRefreshToken()){
                return true
            }
//        }
        return false
    }

  var presenter: DashboardPresentationLogic?
  var service: DashboardService?
    
    private var fetcher = NetworkFetcher()
    private var isLogout: Bool = false
    private var topGuidResponse: TopGuideResponse?
    private var onlineNowResponse: OnlineNowResponse?
    private var freshTourResponse: FreshTourResponse?
    
  func makeRequest(request: Dashboard.Model.Request.RequestType) {
    if service == nil {
      service = DashboardService()
    }
    switch request {
    case .getTopGuids:
        fetcher.userFetcher.request(service: .topRatedGuids(model: GetTopGuids(page: 1, count: 3)),
                                    decodeType: TopGuideResponse.self) {[weak self] (response) in
                                        switch (response){
                                        case .success(let result):
                                            self?.topGuidResponse = result
                                            self!.presentTopGuids()
                                        case .failure(let error):
                                            self?.topGuidResponse = nil
                                            print("Get Top Guids Error: \n \(error.localizedDescription)")
                                        }
        }
    case .getComingTours:
        fetcher.tourFetcher.request(service: .freshtour(model: StreamingModel(page:1, count:3)),
                                    decodeType: FreshTourResponse.self) {[weak self] (response) in
                                        switch (response){
                                        case .success(let result):
                                            self?.freshTourResponse = result
                                            self!.presentFreshTour()
                                        case .failure(let error):
                                            self?.freshTourResponse = nil
                                            print("Get Fresh Tours Error: \n \(error.localizedDescription)")
                                        }
        }
    case .getOnlineTours:
        fetcher.tourFetcher.request(service: .streaming(model: StreamingModel(page: 1, count: 10)),
                                    decodeType: OnlineNowResponse.self) {[weak self] (response) in
                                        switch (response){
                                        case .success(let result):
                                            self?.onlineNowResponse = result
                                            self?.presentOnlineNow()
                                        case .failure(let error):
                                            self?.onlineNowResponse = nil
                                            print("Get online now tours error: \n \(error.localizedDescription)")
                                        }
        }
    }
  }
    func presentTopGuids(){
        guard let topGuidResponse = topGuidResponse else { return }
        presenter?.presentData(response: .presentTopGuids(topGuides: topGuidResponse))
    }
   
    func presentFreshTour(){
        guard let freshTourResponse = freshTourResponse else { return }
        presenter?.presentData(response: .presentComingTours(freshTours: freshTourResponse))
    }
    
    func presentOnlineNow(){
        presenter?.presentData(response: .presentOnlineTours(onlineNow: onlineNowResponse))
    }
}
