//
//  NewsfeedModels.swift
//  NewsFeedVK
//
//  Created by Евгений Уланов on 08.06.2020.
//  Copyright (c) 2020 Евгений Уланов. All rights reserved.
//

import UIKit

enum Newsfeed {
   
  enum Model {
    struct Request {
      enum RequestType {
        case getNewsfeed
        case revealPostIds(postId: Int)
      }
    }
    struct Response {
      enum ResponseType {
        case presentNewsFeed(feed: FeedResponse, revealdedPostIds: [Int])
      }
    }
    struct ViewModel {
      enum ViewModelData {
        case displayNewsfeed(feedViewModel: FeedViewModel)
      }
    }
  }
}

struct FeedViewModel{
    struct Cell:FeedCellViewModel {
        var postId:Int
        var iconUrlString: String
        var name: String
        var date: String
        var text: String?
        var likes: String?
        var comments: String?
        var shared: String?
        var views: String?
        var photoAttachment: FeedCellPhotoAttachmentViewModel?
        var sizes: FeedCellSizes
    }
    struct FeedCellPhotoAttachment: FeedCellPhotoAttachmentViewModel{
        var photoUrlString: String?
        var height: Int
        var width: Int
    }
    let cells:[Cell]
}
