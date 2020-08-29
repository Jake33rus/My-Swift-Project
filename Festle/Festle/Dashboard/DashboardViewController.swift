//
//  DashboardViewController.swift
//  Festle
//
//  Created by Евгений Уланов on 12.07.2020.
//  Copyright (c) 2020 Евгений Уланов. All rights reserved.
//

import UIKit

protocol DashboardDisplayLogic: class {
  func displayData(viewModel: Dashboard.Model.ViewModel.ViewModelData)
}

class DashboardViewController: UIViewController, DashboardDisplayLogic {
    @IBOutlet weak var carouselTours: UICollectionView!
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var playVideoButton: UIButton!
    @IBOutlet weak var guidesTableView: UITableView!
    @IBOutlet weak var topGuidesLabel: UILabel!
    @IBOutlet weak var upcomingToursLabel: UILabel!
    @IBOutlet weak var toursTableView: UITableView!
    let selfToMoreGuidsSegueName = "showMoreGuides"
    let selfToMoreFestsSegueName = "showMoreTours"
    let selfToSearchControllerSegueName = "showSearchAll"
    let selfToMoreGuidInfoSegueName = "showGuidInfo"
    let selfToMoreTourInfoSegueName = "showTourInfo"
    
    private var testData = [
        CarouselTourModel(mainImage: UIImage(named: "nature1")!, tourName: "tour1"),
        CarouselTourModel(mainImage: UIImage(named: "nature2")!, tourName: "tour2"),
        CarouselTourModel(mainImage: UIImage(named: "nature3")!, tourName: "tour3"),
        CarouselTourModel(mainImage: UIImage(named: "nature1")!, tourName: "tour4"),
        CarouselTourModel(mainImage: UIImage(named: "nature2")!, tourName: "tour5")
    ]
    
  var interactor: DashboardBusinessLogic?
  var router: (NSObjectProtocol & DashboardRoutingLogic)?
  private var tourDataSource: InfiniteCollectionViewDataSource<CarouselCell, CarouselTourModel>?
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
    let interactor            = DashboardInteractor()
    let presenter             = DashboardPresenter()
    let router                = DashboardRouter()
    viewController.interactor = interactor
    viewController.router     = router
    interactor.presenter      = presenter
    presenter.viewController  = viewController
    router.viewController     = viewController
  }
  
  // MARK: Routing
  

  
  // MARK: View lifecycle
    @IBAction func logoutButtonPressed(_ sender: Any) {
        if (interactor!.logoutPress()){
            let loginPage = self.storyboard?.instantiateViewController(withIdentifier: "login") as! LoginViewController
            let sceneDelegate = self.view.window?.windowScene?.delegate
            sceneDelegate.
        }
    }
    
  override func viewDidLoad() {
    super.viewDidLoad()
    configurateCarousel()
  }
  
  func displayData(viewModel: Dashboard.Model.ViewModel.ViewModelData) {

  }

    func configurateCarousel(){
        carouselTours.showsVerticalScrollIndicator = false
        carouselTours.showsHorizontalScrollIndicator = false
        carouselTours.backgroundColor = .clear
        carouselTours.decelerationRate = .fast
        carouselTours.collectionViewLayout = DashboardFlowLayout()
        carouselTours.register(CarouselCell.self)

        tourDataSource = InfiniteCollectionViewDataSource(
            data: testData,
            cellClass: CarouselCell.self
        ) { testData, cell in
            cell.configure(title: testData.tourName, image: testData.mainImage)
        }
        carouselTours.dataSource = tourDataSource
        DispatchQueue.main.async {
            self.carouselTours.scrollToItem(
                at: IndexPath(item: 500, section: 0),
                at: .centeredHorizontally,
                animated: false
            )
        }
    }
    @IBAction func moreGuidesButPress(_ sender: Any) {
        self.performSegue(withIdentifier: self.selfToMoreGuidsSegueName, sender: nil)
    }
    
    @IBAction func upcomingToursButPress(_ sender: Any) {
        self.performSegue(withIdentifier: self.selfToMoreFestsSegueName, sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        self.router?.prepare(for: segue, sender: sender)
    }
    
    @IBAction func unwindToDashboardWithGuidCard(segue: UIStoryboardSegue){
           
       }
    //Test Data
    private var favoriteGuids: [GuidCell] = TestData.favoriteGuids
    private var favoriteFests: [FestCell] = TestData.favoriteFests
}


extension DashboardViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == self.guidesTableView {
            self.guidesTableView.register(UINib(nibName: "FGuidCell", bundle: nil), forCellReuseIdentifier: "cellGuideId")
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellGuideId", for: indexPath) as! FavoriteGuideCell
            let guide = favoriteGuids[indexPath.row]
            cell.photo.image = guide.photo
            cell.cityLabel.text = guide.city
            cell.likesCount.text = String(guide.likes)
            cell.nameLabel.text = guide.nameLabel
            cell.tourCount.text = String(guide.coutTour)
            return cell
            
        } else {
            self.toursTableView.register(UINib(nibName: "FestCell", bundle: nil), forCellReuseIdentifier: "FestCellId")
            let cell = tableView.dequeueReusableCell(withIdentifier: "FestCellId", for: indexPath) as! FavoriteFestCell
            let fest = favoriteFests[indexPath.row]
            cell.isPaid = fest.isPaid
            cell.photo.image = fest.image
            cell.tourDescriptionLabel.text = fest.descriptionLabel
            cell.tourNameLabel.text = fest.nameLabel
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == self.guidesTableView{
            let selectedTrail = favoriteGuids[indexPath.row]
            self.performSegue(withIdentifier: selfToMoreGuidInfoSegueName, sender: nil)
        }
        if tableView == self.toursTableView{
            let selectedTrail = favoriteFests[indexPath.row]
            self.performSegue(withIdentifier: selfToMoreTourInfoSegueName, sender: nil)
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
}
