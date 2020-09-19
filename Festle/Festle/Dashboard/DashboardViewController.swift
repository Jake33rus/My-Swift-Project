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
    @IBOutlet weak var onlineLabel: UILabel! {
        didSet{
            onlineLabel.text = NSLocalizedString("Online now", comment: "")
        }
    }
    @IBOutlet weak var playVideoButton: UIButton!
    @IBOutlet weak var guidesTableView: UITableView!
    @IBOutlet weak var topGuidesLabel: UILabel!{
        didSet{
            topGuidesLabel.text = NSLocalizedString("Top guides", comment: "")
        }
    }
    @IBOutlet weak var upcomingToursLabel: UILabel!
    {
        didSet{
            upcomingToursLabel.text = NSLocalizedString("Upcoming tours", comment: "")
        }
    }
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

    private var tourDataSource: InfiniteCollectionViewDataSource<CarouselCell, OnlineToursViewModel.DisplayOnlineTour>?
    
    private var topGuidViewModel = DashbordGuidViewModel.init(topGuids: [])
    private var onlineNowTourViewModel = OnlineToursViewModel.init(onlineNow: [])
    private var freshToursViewModel = DashboardTourViewModel.init(comingTours: [], fullTours: nil)
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
            let appDelegate = UIApplication.shared.delegate
            appDelegate?.window??.rootViewController = loginPage
        }
    }
    
  override func viewDidLoad() {
    super.viewDidLoad()
    configurateCarousel()
    self.guidesTableView.showActivityIndicator()
    interactor?.makeRequest(request: .getTopGuids)
    interactor?.makeRequest(request: .getOnlineTours)
    interactor?.makeRequest(request: .getComingTours)
  }
  
  func displayData(viewModel: Dashboard.Model.ViewModel.ViewModelData) {
    switch (viewModel) {
    case .displayOnlineTours(onlineTours: let onlineTours):
        self.onlineNowTourViewModel = onlineTours
        carouselTours.hideNullIndicator()
        configurateCarousel()
        carouselTours.reloadData()
    case .displayTopGuids(topGuids: let topGuids):
        self.topGuidViewModel = topGuids
        guidesTableView.hideActivityIndicator()
        guidesTableView.reloadData()
    case .displatComingTours(comingTours: let comingTours):
        self.freshToursViewModel = comingTours
        toursTableView.hideActivityIndicator()
        toursTableView.reloadData()
    case .displateNotOnlineTours:
        displayNotNowEventLable()
    }
  }

    func displayNotNowEventLable(){
        let newFrame = CGRect(x:0, y:0, width:carouselTours.frame.width, height:0)
        carouselTours.frame = newFrame
//        carouselTours.isHidden = true
//        onlineLabel.isHidden = true
        //carouselTours.showNullIndicator()
    }
    
    func configurateCarousel(){
        if (onlineNowTourViewModel.onlineNow.count != 0){
        carouselTours.showsVerticalScrollIndicator = false
        carouselTours.showsHorizontalScrollIndicator = false
        carouselTours.backgroundColor = .clear
        carouselTours.decelerationRate = .fast
        carouselTours.collectionViewLayout = DashboardFlowLayout()
        carouselTours.register(CarouselCell.self)

        tourDataSource = InfiniteCollectionViewDataSource(
            data: onlineNowTourViewModel.onlineNow,
            cellClass: CarouselCell.self
        ) { data, cell in
            cell.configure(title: data.name, image: UIImage(named: "nature1")!)
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
        else {
            carouselTours.showNullIndicator()
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
            let guide = topGuidViewModel.topGuids[indexPath.row]
            cell.photo = WebImageView(image: UIImage.init(named: "nature1"))
            cell.cityLabel.text = guide.city
            cell.likesCount.text = guide.likes
            cell.nameLabel.text = guide.name
            cell.tourCount.text = guide.tours
            return cell
            
        } else {
            self.toursTableView.register(UINib(nibName: "FestCell", bundle: nil), forCellReuseIdentifier: "FestCellId")
            let cell = tableView.dequeueReusableCell(withIdentifier: "FestCellId", for: indexPath) as! FavoriteFestCell
            let fest = freshToursViewModel.comingTours[indexPath.row]
            cell.isPaid = fest.isPaidStatus
            cell.photo = WebImageView(image: UIImage.init(named: "nature1"))
            cell.tourDescriptionLabel.text = fest.descr
            cell.tourNameLabel.text = fest.name
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
        if tableView == self.guidesTableView{
            return topGuidViewModel.topGuids.count
        }
        else if tableView == self.toursTableView{
            return freshToursViewModel.comingTours.count
        }
        else {
            return 3
        }
    }
}

extension DashboardViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedTrail = testData[indexPath.row%testData.count]
        print("Corousel click \(selectedTrail.tourName) cell")
    }
}
