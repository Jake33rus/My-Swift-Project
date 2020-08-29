//
//  NewsfeedInteractor.swift
//  NewsFeedVK
//
//  Created by Евгений Уланов on 08.06.2020.
//  Copyright (c) 2020 Евгений Уланов. All rights reserved.
//

import UIKit

protocol NewsfeedBusinessLogic {
  func makeRequest(request: Newsfeed.Model.Request.RequestType)
}

class NewsfeedInteractor: NewsfeedBusinessLogic {

  var presenter: NewsfeedPresentationLogic?
  var service: NewsfeedService?
    
    private var revealedPostIds = [Int]()
    private var feedResponse: FeedResponse?
    private var fetcher:DataFetcher = NetworkDataFetcher(networking: NetworkSevice())
  
  func makeRequest(request: Newsfeed.Model.Request.RequestType) {
    if service == nil {
      service = NewsfeedService()
    }
    switch request {
    case .getNewsfeed:
        fetcher.getFeed { [weak self] (feedResponse) in
            
            self?.feedResponse = feedResponse
            self?.presentFeed()
        }
        
    case .revealPostIds(postId: let postId):
        revealedPostIds.append(postId)
        presentFeed()
    }
  }
    private func presentFeed(){
        guard let feedResponse = feedResponse else { return }
        presenter?.presentData(response: .presentNewsFeed(feed: feedResponse, revealdedPostIds: revealedPostIds))
    }
}
