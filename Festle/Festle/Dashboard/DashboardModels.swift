//
//  DashboardModels.swift
//  Festle
//
//  Created by Евгений Уланов on 12.07.2020.
//  Copyright (c) 2020 Евгений Уланов. All rights reserved.
//

import UIKit

enum Dashboard {
   
  enum Model {
    struct Request {
      enum RequestType {
        case getTopGuids
        case getComingTours
        case getOnlineTours
      }
    }
    struct Response {
      enum ResponseType {
        case presentTopGuids(topGuides: TopGuideResponse)
        case presentComingTours(freshTours: FreshTourResponse)
        case presentOnlineTours(onlineNow: OnlineNowResponse?)
      }
    }
    struct ViewModel {
      enum ViewModelData {
        case displayOnlineTours(onlineTours: OnlineToursViewModel)
        case displayTopGuids(topGuids: DashbordGuidViewModel)
        case displatComingTours(comingTours: DashboardTourViewModel)
        case displateNotOnlineTours
      }
    }
  }
  
}

struct OnlineToursViewModel{
    struct DisplayOnlineTour {
        let id: Int
        let name: String
        let photo: String
    }
    let onlineNow:[DisplayOnlineTour]
}

struct DashbordGuidViewModel{
    
    struct DashboardGuid{
        let email: String
        let photo: String?
        let name, city, likes, tours: String
    }
    
    let topGuids:[DashboardGuid]
}

struct DashboardTourViewModel{
    struct DashboardTour{
        let id: Int32
        let photo: String?
        let name, descr: String
        let isPaidStatus: Bool
    }
    let comingTours:[DashboardTour]
    let fullTours:FreshTourResponse?
}
