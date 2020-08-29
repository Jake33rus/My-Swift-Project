//
//  TVSceneViewController.swift
//  Festle
//
//  Created by Евгений Уланов on 03.08.2020.
//  Copyright (c) 2020 Евгений Уланов. All rights reserved.
//

import UIKit

protocol TVSceneDisplayLogic: class {
  func displayData(viewModel: TVScene.Model.ViewModel.ViewModelData)
}

class TVSceneViewController: UIViewController, TVSceneDisplayLogic {

    @IBOutlet weak var searchTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var sceneName: UILabel!
    var interactor: TVSceneBusinessLogic?
  var router: (NSObjectProtocol & TVSceneRoutingLogic)?

  // MARK: Object lifecycle
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    setup()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }
  
  // MARK: Setup
  
  private func setup() {
    let viewController        = self
    let interactor            = TVSceneInteractor()
    let presenter             = TVScenePresenter()
    let router                = TVSceneRouter()
    viewController.interactor = interactor
    viewController.router     = router
    interactor.presenter      = presenter
    presenter.viewController  = viewController
    router.viewController     = viewController
  }
  
  // MARK: Routing
  
    private func configurateScene(){
        switch sceneType {
        case .Guids:
            data = TestData.favoriteGuids
            filteredData = data
            sceneName.text = NSLocalizedString("Top guides", comment: "")
        case .Fests:
            data = TestData.favoriteFests
            filteredData = data
            sceneName.text = NSLocalizedString("Upcoming tours", comment: "")
        case .Search:
            data = TestData.favoriteGuids
            data?.append(contentsOf: TestData.favoriteFests)
            filteredData = data
            sceneName.text = NSLocalizedString("Find text", comment: "")
        }
    }

  
  // MARK: View lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configurateScene()
  }
  
  func displayData(viewModel: TVScene.Model.ViewModel.ViewModelData) {

  }
    var data:[Any]?
    var filteredData:[Any]?
    var sceneType: TVScene.SceneType = .Search
}

extension TVSceneViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch sceneType {
        case .Guids:
            self.searchTableView.register(UINib(nibName: "FGuidCell", bundle: nil), forCellReuseIdentifier: "cellGuideId")
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellGuideId", for: indexPath) as! FavoriteGuideCell
            let guide = filteredData![indexPath.row] as! GuidCell
            cell.photo.image = guide.photo
            cell.cityLabel.text = guide.city
            cell.likesCount.text = String(guide.likes)
            cell.nameLabel.text = guide.nameLabel
            cell.tourCount.text = String(guide.coutTour)
            return cell
        case .Fests:
            self.searchTableView.register(UINib(nibName: "FestCell", bundle: nil), forCellReuseIdentifier: "FestCellId")
            let cell = tableView.dequeueReusableCell(withIdentifier: "FestCellId", for: indexPath) as! FavoriteFestCell
            let fest = filteredData![indexPath.row] as! FestCell
            cell.isPaid = fest.isPaid
            cell.photo.image = fest.image
            cell.tourDescriptionLabel.text = fest.descriptionLabel
            cell.tourNameLabel.text = fest.nameLabel
            return cell
        case .Search:
            //TODO: UPDATE
            self.searchTableView.register(UINib(nibName: "FGuidCell", bundle: nil), forCellReuseIdentifier: "cellGuideId")
            self.searchTableView.register(UINib(nibName: "FestCell", bundle: nil), forCellReuseIdentifier: "FestCellId")
            let data = filteredData![indexPath.row]
            if data is GuidCell{
                let cell = tableView.dequeueReusableCell(withIdentifier: "cellGuideId", for: indexPath) as! FavoriteGuideCell
                let guide = data as! GuidCell
                cell.photo.image = guide.photo
                cell.cityLabel.text = guide.city
                cell.likesCount.text = String(guide.likes)
                cell.nameLabel.text = guide.nameLabel
                cell.tourCount.text = String(guide.coutTour)
                return cell
            }
            else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "FestCellId", for: indexPath) as! FavoriteFestCell
                let fest = data as! FestCell
                cell.isPaid = fest.isPaid
                cell.photo.image = fest.image
                cell.tourDescriptionLabel.text = fest.descriptionLabel
                cell.tourNameLabel.text = fest.nameLabel
                return cell
            }
           
        }
        
    }
}

extension TVSceneViewController: UISearchBarDelegate{
    
}
