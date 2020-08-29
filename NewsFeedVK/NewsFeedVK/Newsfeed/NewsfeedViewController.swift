//
//  NewsfeedViewController.swift
//  NewsFeedVK
//
//  Created by Евгений Уланов on 08.06.2020.
//  Copyright (c) 2020 Евгений Уланов. All rights reserved.
//

import UIKit

protocol NewsfeedDisplayLogic: class {
  func displayData(viewModel: Newsfeed.Model.ViewModel.ViewModelData)
}

class NewsfeedViewController: UIViewController, NewsfeedDisplayLogic, NewsfeedCodeCellDelegate {
    

  var interactor: NewsfeedBusinessLogic?
  var router: (NSObjectProtocol & NewsfeedRoutingLogic)?
  
    private var feedViewModel = FeedViewModel.init(cells: [])
    
    @IBOutlet weak var table: UITableView!
    // MARK: Setup
  
  private func setup() {
    let viewController        = self
    let interactor            = NewsfeedInteractor()
    let presenter             = NewsfeedPresenter()
    let router                = NewsfeedRouter()
    viewController.interactor = interactor
    viewController.router     = router
    interactor.presenter      = presenter
    presenter.viewController  = viewController
    router.viewController     = viewController
  }
  
  // MARK: Routing
  

  
  // MARK: View lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
    
    table.register(UINib(nibName: "NewsfeedCell", bundle: nil), forCellReuseIdentifier: NewsfeedCell.reuseId)
    
    table.register(NewsfeedCodeCell.self, forCellReuseIdentifier: NewsfeedCodeCell.reuseId)
    
    table.separatorStyle = .none
    table.backgroundColor = .clear
    view.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
    
    interactor?.makeRequest(request: .getNewsfeed)
  }
  
  func displayData(viewModel: Newsfeed.Model.ViewModel.ViewModelData) {
    switch viewModel {
    case .displayNewsfeed(feedViewModel: let feedViewModel):
        self.feedViewModel = feedViewModel
        table.reloadData()
    }
}
    //MARK: NewsfeedCodeCellDelegate
    func revealPost(for cell: NewsfeedCodeCell) {
        guard let indexPath = table.indexPath(for: cell) else {return}
        let cellViewModel = feedViewModel.cells[indexPath.row]
        
        interactor?.makeRequest(request: Newsfeed.Model.Request.RequestType.revealPostIds(postId: cellViewModel.postId))
    }
    
}

extension NewsfeedViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedViewModel.cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: NewsfeedCell.reuseId, for: indexPath)
//            as! NewsfeedCell
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsfeedCodeCell.reuseId,
                                                 for: indexPath) as! NewsfeedCodeCell
        let cellViewModel = feedViewModel.cells[indexPath.row]
        cell.set(viewModel: cellViewModel)
        cell.delegate = self
        return cell
    }

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellViewModel = feedViewModel.cells[indexPath.row]
        return cellViewModel.sizes.totalHeight
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellViewModel = feedViewModel.cells[indexPath.row]
        return cellViewModel.sizes.totalHeight
    }
}
