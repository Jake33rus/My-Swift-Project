//
//  DashboardPresenter.swift
//  Festle
//
//  Created by Евгений Уланов on 12.07.2020.
//  Copyright (c) 2020 Евгений Уланов. All rights reserved.
//

import UIKit

protocol DashboardPresentationLogic {
  func presentData(response: Dashboard.Model.Response.ResponseType)
}

class DashboardPresenter: DashboardPresentationLogic {
  weak var viewController: DashboardDisplayLogic?
  
  func presentData(response: Dashboard.Model.Response.ResponseType) {
    switch (response){
    case .presentTopGuids(topGuides: let topGuides):
        let guidCells = topGuides.data.map { (guid) in
            cellTopGuidViewModel(from: guid)
        }
        let topGuidViewModel = DashbordGuidViewModel.init(topGuids: guidCells)
        viewController?.displayData(viewModel: .displayTopGuids(topGuids: topGuidViewModel))
    case .presentComingTours(freshTours: let freshTours):
        let tourCell = freshTours.data.map { (tour) in
            cellFreshTourViewModel(from: tour)
        }
        let tourViewModel = DashboardTourViewModel.init(comingTours: tourCell, fullTours: freshTours)
        viewController?.displayData(viewModel: .displatComingTours(comingTours: tourViewModel))
    case .presentOnlineTours(onlineNow: let onlineNow):
        let onlineNowCells = onlineNow!.data.map { (tour) in
            cellOnlineNowViewModel(from: tour)
        }
        let onlineNowViewModel = OnlineToursViewModel.init(onlineNow: onlineNowCells)
        if (onlineNowViewModel.onlineNow.count != 0){
        viewController?.displayData(viewModel: .displayOnlineTours(onlineTours: onlineNowViewModel))
        }
        else{
            viewController?.displayData(viewModel: .displateNotOnlineTours)
        }
    }
  }
    private func cellFreshTourViewModel(from freshTour: FreshTourDatum) ->DashboardTourViewModel.DashboardTour{
        return DashboardTourViewModel.DashboardTour.init(id: Int32(freshTour.id),
                                                         photo: freshTour?.photos[0].fileName,
                                                         name: freshTour.name,
                                                         descr: freshTour.description,
                                                         isPaidStatus: !freshTour.isFree)
    }
    
    private func cellTopGuidViewModel(from topGuid: DatumTopGuid) -> DashbordGuidViewModel.DashboardGuid{
        return DashbordGuidViewModel.DashboardGuid.init(email: topGuid.email,
                                                        photo: topGuid.photo?.fileName,
                                                        name: topGuid.name,
                                                        city: topGuid.city,
                                                        likes: String(topGuid.likesCount),
                                                        tours: String(topGuid.tourCount))
    }
    
    private func cellOnlineNowViewModel(from onlineNowTour: DatumOnline) -> OnlineToursViewModel.DisplayOnlineTour{
        return OnlineToursViewModel.DisplayOnlineTour.init(id: onlineNowTour.id,
                                                           name: onlineNowTour.name,
                                                           photo: onlineNowTour.photos[0].fileName)
    }
}
