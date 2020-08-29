//
//  NewsfeedPresenter.swift
//  NewsFeedVK
//
//  Created by Евгений Уланов on 08.06.2020.
//  Copyright (c) 2020 Евгений Уланов. All rights reserved.
//

import UIKit

protocol NewsfeedPresentationLogic {
  func presentData(response: Newsfeed.Model.Response.ResponseType)
}

class NewsfeedPresenter: NewsfeedPresentationLogic {
  weak var viewController: NewsfeedDisplayLogic?
    
    var cellLayoutCalculator: FeedCellLayoutCalculatorProtocol = FeedCellLayoutCalculator()
    
    let dateFormatter: DateFormatter = {
        let dt = DateFormatter()
        dt.locale = Locale(identifier: "ru_RU")
        dt.dateFormat = "d MMM 'в' HH:mm"
        return dt
    }()
  
  func presentData(response: Newsfeed.Model.Response.ResponseType) {
    switch response {
    case .presentNewsFeed(feed: let feed, let revealdedPostIds):
        let cells = feed.items.map {(feedItem) in
            cellViewModel(from: feedItem, profiles: feed.profiles, groups: feed.groups,
                          revealdedPostIds: revealdedPostIds)
        }
        let feedViewModel = FeedViewModel.init(cells: cells)
        viewController?.displayData(viewModel: .displayNewsfeed(feedViewModel: feedViewModel))
    }
  }
    private func cellViewModel(from feedItem:FeedItem, profiles: [Profile], groups: [Group],
                               revealdedPostIds:[Int]) -> FeedViewModel.Cell {
        let profile = self.progfile(for: feedItem.sourceId, profiles: profiles, groups: groups)
        let photoAttacment = self.photoAttachment(feedItem: feedItem)
        let date = Date(timeIntervalSince1970: feedItem.date)
        let dateTitle = dateFormatter.string(from: date)
        
        let isFullSized = revealdedPostIds.contains(feedItem.postId)
        
        let sizes = cellLayoutCalculator.sizes(postText: feedItem.text,
                                               photoAttachment: photoAttacment,
                                               isFullSizedPost: isFullSized)
        
        return FeedViewModel.Cell.init(postId: feedItem.postId,
                                       iconUrlString: profile.photo,
                                       name: profile.name,
                                       date: dateTitle,
                                       text: feedItem.text,
                                       likes: String(feedItem.likes?.count ?? 0),
                                       comments: String(feedItem.comments?.count ?? 0),
                                       shared: String(feedItem.reposts?.count ?? 0),
                                       views: String(feedItem.views?.count ?? 0),
                                       photoAttachment: photoAttacment,
                                       sizes: sizes)
                                        
    }
    
    private func photoAttachment(feedItem:FeedItem) -> FeedViewModel.FeedCellPhotoAttachment? {
        guard let photos = feedItem.attachments?.compactMap({ (attachment) in
            attachment.photo}), let firstPhoto = photos.first else { return nil }
        return FeedViewModel.FeedCellPhotoAttachment.init(photoUrlString: firstPhoto.srcBIG,
                                                          height: firstPhoto.height,
                                                          width: firstPhoto.width)
    }
    
    private func progfile(for sourseId: Int, profiles: [Profile], groups: [Group]) -> ProfileRepresentable{
        let profilesOrGroups: [ProfileRepresentable] = sourseId >= 0 ? profiles : groups
        let normalSourseId = sourseId >= 0 ? sourseId : -sourseId
        let profileRepresentable = profilesOrGroups.first { (myProfileRepresentable) -> Bool in
            myProfileRepresentable.id == normalSourseId
        }
        return profileRepresentable!
    }
}
