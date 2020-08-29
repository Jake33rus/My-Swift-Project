//
//  FavoriteViewController.swift
//  Festle
//
//  Created by Евгений Уланов on 12.07.2020.
//  Copyright (c) 2020 Евгений Уланов. All rights reserved.
//

import UIKit

protocol FavoriteDisplayLogic: class {
  func displayData(viewModel: Favorite.Model.ViewModel.ViewModelData)
}

class FavoriteViewController: UIViewController, FavoriteDisplayLogic {

  var interactor: FavoriteBusinessLogic?
  var router: (NSObjectProtocol & FavoriteRoutingLogic)?
        
 
    @IBOutlet weak var segmentedControl: CustomSegmentedControl!
    @IBOutlet weak var fTableView: UITableView!
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
    let interactor            = FavoriteInteractor()
    let presenter             = FavoritePresenter()
    let router                = FavoriteRouter()
    viewController.interactor = interactor
    viewController.router     = router
    interactor.presenter      = presenter
    presenter.viewController  = viewController
    router.viewController     = viewController
  }
  
  // MARK: Routing
  

  // MARK: Design settings
    
    private func setupDesign() {
        segmentedControl.items = [NSLocalizedString("Guides", comment: ""),
                                  NSLocalizedString("Excursions", comment: "")]
        segmentedControl.borderColor = #colorLiteral(red: 0, green: 0.693600595, blue: 0.9541637301, alpha: 1)
        segmentedControl.selectedLabelColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        segmentedControl.unselectedLabelColor = #colorLiteral(red: 0, green: 0.693600595, blue: 0.9541637301, alpha: 1)
        segmentedControl.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        segmentedControl.thumbColor = #colorLiteral(red: 1, green: 0.662745098, blue: 0.1294117647, alpha: 1)
        segmentedControl.selectedIndex = 0
        segmentedControl.addTarget(self, action: #selector(segmentValueChanged(_:)), for: .valueChanged)
    }

    @objc func segmentValueChanged(_ sender: AnyObject?){
        fTableView.reloadData()
//        if segmentedControl.selectedIndex == 0 {
//            //view guides table
//            print("guides")
//        }else if segmentedControl.selectedIndex == 1{
//            //view excursion tabel
//            print("ecscursion")
//        }
    }
  // MARK: View lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupDesign()
  }
  
  func displayData(viewModel: Favorite.Model.ViewModel.ViewModelData) {

  }
    //Test data
    private var favoriteGuids: [GuidCell] = [GuidCell(photo: UIImage(named: "face")!,
                                                         nameLabel: "Joe Testers",
                                                         coutTour: 200,
                                                         city: "Moscow",
                                                         likes: 250),
                                                GuidCell(photo: UIImage(named: "face")!,
                                                         nameLabel: "Mark Testers",
                                                         coutTour: 82,
                                                         city: "Roma",
                                                         likes: 25000),
                                                GuidCell(photo: UIImage(named: "face")!,
                                                         nameLabel: "Joe Testers",
                                                         coutTour: 171,
                                                         city: "Praga",
                                                         likes: 4823)]
       private var favoriteFests: [FestCell] = [FestCell(image: UIImage(named: "nature1")!,
                                                         nameLabel: "По озерам Тайги",
                                                         descriptionLabel: "блаблаблаблаблаблаблаблаблаблаблаблаблаблаблаблаблабла",
                                                         isPaid: true),
                                                FestCell(image: UIImage(named: "nature2")!,
                                                         nameLabel: "Красоты природы Австралии",
                                                         descriptionLabel: "блаблаблаблаблаблаблаблаблаблаблаблаблаблаблаблаблабла",
                                                         isPaid: false)]
}

extension FavoriteViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if segmentedControl.selectedIndex == 0 {
            self.fTableView.register(UINib(nibName: "FGuidCell", bundle: nil), forCellReuseIdentifier: "cellGuideId")
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellGuideId", for: indexPath) as! FavoriteGuideCell
            let guide = favoriteGuids[indexPath.row]
            cell.photo.image = guide.photo
            cell.cityLabel.text = guide.city
            cell.likesCount.text = String(guide.likes)
            cell.nameLabel.text = guide.nameLabel
            cell.tourCount.text = String(guide.coutTour)
            return cell
            
        } else {
            self.fTableView.register(UINib(nibName: "FestCell", bundle: nil), forCellReuseIdentifier: "FestCellId")
            let cell = tableView.dequeueReusableCell(withIdentifier: "FestCellId", for: indexPath) as! FavoriteFestCell
            let fest = favoriteFests[indexPath.row]
            cell.isPaid = fest.isPaid
            cell.photo.image = fest.image
            cell.tourDescriptionLabel.text = fest.descriptionLabel
            cell.tourNameLabel.text = fest.nameLabel
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if segmentedControl.selectedIndex == 0 {
            return favoriteGuids.count
        } else {
            return favoriteFests.count
        }
    }
}

