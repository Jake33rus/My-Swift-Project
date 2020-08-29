//
//  TourCardViewController.swift
//  Festle
//
//  Created by Евгений Уланов on 23.08.2020.
//  Copyright (c) 2020 Евгений Уланов. All rights reserved.
//

import UIKit

protocol TourCardDisplayLogic: class {
  func displayData(viewModel: TourCard.Model.ViewModel.ViewModelData)
}

class TourCardViewController: UIViewController, TourCardDisplayLogic {

  var interactor: TourCardBusinessLogic?
  var router: (NSObjectProtocol & TourCardRoutingLogic)?
    
    @IBOutlet weak var tourImage: UIImageView!
    @IBOutlet weak var tourName: UILabel!
    @IBOutlet weak var objectsAndHoursLabel: UILabel!
    @IBOutlet weak var tourDescr: UILabel!
    @IBOutlet weak var mapView: UIView!
    @IBOutlet weak var tourPointsTableView: UITableView!
    @IBOutlet weak var goToStreamButton: UIButton!
    @IBOutlet weak var tbHeight: NSLayoutConstraint!
    
    var tourPoints: [TourPoint]? = nil
    var isStream: Bool = false
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
    let interactor            = TourCardInteractor()
    let presenter             = TourCardPresenter()
    let router                = TourCardRouter()
    viewController.interactor = interactor
    viewController.router     = router
    interactor.presenter      = presenter
    presenter.viewController  = viewController
    router.viewController     = viewController
  }
  
  // MARK: Routing
  
    func testDataInit(){
        let tourInfo = TestData.testTour
        tourImage.image = tourInfo.excursionPhoto
        tourName.text = tourInfo.excursionName
        objectsAndHoursLabel.text = String(tourInfo.objectCount) + "objects, " + String(tourInfo.hoursCount) + "hours"
        tourDescr.text = tourInfo.excursionDescr
        self.tourPoints = tourInfo.tourPoints
    }

  
  // MARK: View lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    testDataInit()
  }
  
    override func viewWillAppear(_ animated: Bool) {
        self.tourPointsTableView.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
        self.tourPointsTableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tourPointsTableView.removeObserver(self, forKeyPath: "contentSize")
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "contentSize"{
            if object is UITableView{
                if let newvalue = change?[.newKey]{
                    let newsize = newvalue as! CGSize
                    self.tbHeight.constant = CGFloat(tourPoints!.count * 260)
                }
            }
        }
    }
  func displayData(viewModel: TourCard.Model.ViewModel.ViewModelData) {

  }
    @IBAction func closeButtonPress(_ sender: Any) {
    }
    @IBAction func likeButtonPress(_ sender: Any) {
    }
    @IBAction func goToStreamButtonPress(_ sender: Any) {
    }
    
}

extension TourCardViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tourPoints!.count
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableView.automaticDimension
//    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        self.tourPointsTableView.register(UINib(nibName: "TourPointCell", bundle: nil), forCellReuseIdentifier: "TourPoint")
        let cell = tourPointsTableView.dequeueReusableCell(withIdentifier: "TourPoint", for: indexPath) as! TourPointCell
        let tourPoint = tourPoints![indexPath.row]
        cell.markNumber.text = String(tourPoint.pointNumber)
        cell.placePhoto.image = tourPoint.placePhoto
        cell.placeAdress.text = tourPoint.placeAdress
        cell.placeDescription.text = tourPoint.placeDescr
        cell.placeName.text = tourPoint.placeName
        return cell
    }
    
    
}
