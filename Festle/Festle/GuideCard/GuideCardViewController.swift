//
//  GuideCardViewController.swift
//  Festle
//
//  Created by Евгений Уланов on 16.08.2020.
//  Copyright (c) 2020 Евгений Уланов. All rights reserved.
//

import UIKit

protocol GuideCardDisplayLogic: class {
  func displayData(viewModel: GuideCard.Model.ViewModel.ViewModelData)
}

class GuideCardViewController: UIViewController, GuideCardDisplayLogic {

    @IBOutlet weak var guidPhoto: UIImageView!
    {
        didSet{
            guidPhoto?.layer.cornerRadius = guidPhoto.frame.size.height / 2
            guidPhoto?.clipsToBounds = true
        }
    }
    
    let unwindSegueToDashboardName = "unwindToDashboard"
    
    @IBOutlet weak var guideName: UILabel!
    @IBOutlet weak var guideCity: UILabel!
    @IBOutlet weak var excursionCount: UILabel!
    @IBOutlet weak var likesCount: UILabel!
    @IBOutlet weak var contactsLabel: UILabel!{
        didSet{
            contactsLabel.text = NSLocalizedString("Contacts", comment: "")
        }
    }
    @IBOutlet weak var contactsInfo: UILabel!
    @IBOutlet weak var aboutGuidLabel: UILabel!{
        didSet{
            aboutGuidLabel.text = NSLocalizedString("About guide", comment: "")
        }
    }
    @IBOutlet weak var aboutInfo: UITextView!{
        didSet{
            aboutInfo.layer.borderWidth = 1.0
            aboutInfo.layer.borderColor = #colorLiteral(red: 0, green: 0.693600595, blue: 0.9541637301, alpha: 1)
            aboutInfo.layer.cornerRadius = 8
            aboutInfo.clipsToBounds = true
        }
    }
    @IBOutlet weak var upcomingToursLabel: UILabel!{
        didSet{
            upcomingToursLabel.text = NSLocalizedString("upcoming tour", comment: "")
        }
    }
    @IBOutlet weak var collectionViewTours: UICollectionView!
    @IBOutlet weak var guidedToursButton: UIButton! {
        didSet{
            guidedToursButton.layer.cornerRadius = 8
            guidedToursButton.clipsToBounds = true
            guidedToursButton.setTitle(NSLocalizedString("Guided tours", comment: ""), for: .normal)
            guidedToursButton.titleLabel?.adjustsFontForContentSizeCategory = true
        }
    }
    @IBOutlet weak var reportedButton: UIButton!{
        didSet{
            reportedButton.layer.cornerRadius = 8
            reportedButton.clipsToBounds = true
            reportedButton.setTitle(NSLocalizedString("Reported", comment: ""), for: .normal)
            reportedButton.titleLabel?.adjustsFontForContentSizeCategory = true
        }
    }
    @IBOutlet weak var languages: UILabel!{
        didSet{
            languages.text = NSLocalizedString("Languages", comment: "")
        }
    }
    @IBOutlet weak var langInfo: UILabel!
    
    
    var interactor: GuideCardBusinessLogic?
    var router: (NSObjectProtocol & GuideCardRoutingLogic)?
    var upcomingTours: [FestCell] = TestData.favoriteFests

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
    let interactor            = GuideCardInteractor()
    let presenter             = GuideCardPresenter()
    let router                = GuideCardRouter()
    viewController.interactor = interactor
    viewController.router     = router
    interactor.presenter      = presenter
    presenter.viewController  = viewController
    router.viewController     = viewController
  }
  
  // MARK: Routing
  
    func testDataInit(){
        let guideInfo = TestData.testGuid
        guideName.text = guideInfo.name
        guideCity.text = guideInfo.city
        aboutInfo.text = guideInfo.aboutInfo
        guidPhoto.image = guideInfo.photo
        upcomingTours = guideInfo.upcomingTours
        likesCount.text = String(guideInfo.likes)
        excursionCount.text = String(guideInfo.countTour)
        contactsInfo.text = guideInfo.contacts
        langInfo.text = guideInfo.languages
    }
  
  // MARK: View lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    testDataInit()
  }
  
  func displayData(viewModel: GuideCard.Model.ViewModel.ViewModelData) {

  }
    @IBAction func likeButton(_ sender: Any) {
    }
    @IBAction func guidedToursPress(_ sender: Any) {
    }
    @IBAction func reportedPress(_ sender: Any) {
    }
    
    @IBAction func backButtonPress(_ sender: Any) {
        self.performSegue(withIdentifier: self.unwindSegueToDashboardName, sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        self.router?.prepare(for: segue, sender: sender)
    }
}

extension GuideCardViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return TestData.testGuid.upcomingTours.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        self.collectionViewTours.register(UINib(nibName: "TourCell", bundle: nil), forCellWithReuseIdentifier: "FestCollectionCell")
        let cell = collectionViewTours.dequeueReusableCell(withReuseIdentifier: "FestCollectionCell", for: indexPath) as! TourCollectionViewCell
        let fest = upcomingTours[indexPath.row]
        cell.isPaidIndicator = fest.isPaid
        cell.tourPhoto.image = fest.image
        cell.tourName.text = fest.nameLabel
        return cell
    }
}
