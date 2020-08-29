//
//  ProfileViewController.swift
//  Festle
//
//  Created by Евгений Уланов on 12.07.2020.
//  Copyright (c) 2020 Евгений Уланов. All rights reserved.
//

import UIKit

protocol ProfileDisplayLogic: class {
  func displayData(viewModel: UserProfile.Model.ViewModel.ViewModelData)
}

class ProfileViewController: UIViewController, ProfileDisplayLogic {

    @IBOutlet weak var editInfoButton: UIButton!
    @IBOutlet weak var settingButton: UIButton!
    @IBOutlet weak var profilePhoto: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userCity: UILabel!
    @IBOutlet weak var userLanguages: UILabel!
    @IBOutlet weak var userContacts: UILabel!
    @IBOutlet weak var cityInfo: UILabel!
    @IBOutlet weak var langInfo: UILabel!
    @IBOutlet weak var contactInfo: UILabel!
    @IBOutlet weak var viewRoutingButton: UIButton!
    @IBOutlet weak var stayGuideButton: UIButton!
    @IBOutlet weak var isGuideImage: UIImageView!
    var interactor: ProfileBusinessLogic?
    var router: (NSObjectProtocol & ProfileRoutingLogic)?
    let selfToEditInfoSegueName = "showEditUserInformation"
    let selfToSettinfSegueName = "showSettings"
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
    let interactor            = ProfileInteractor()
    let presenter             = ProfilePresenter()
    let router                = ProfileRouter()
    viewController.interactor = interactor
    viewController.router     = router
    interactor.presenter      = presenter
    presenter.viewController  = viewController
    router.viewController     = viewController
  }
  
  // MARK: Design Setup
  private func setupDesign(){
    let editIcon = #imageLiteral(resourceName: "edit")
    let settingIcon = #imageLiteral(resourceName: " setting")
    
    editInfoButton.setImage(editIcon, for: .normal)
    editInfoButton.image(for: .normal)?.withRenderingMode(.alwaysTemplate)
    settingButton.setImage(settingIcon, for: .normal)
    settingButton.image(for: .normal)?.withRenderingMode(.alwaysTemplate)
    
    stayGuideButton.layer.cornerRadius = 8
    stayGuideButton.setTitle(NSLocalizedString("Become guide", comment: ""), for: .normal)
    stayGuideButton.titleLabel?.adjustsFontForContentSizeCategory = true
    viewRoutingButton.layer.cornerRadius = 8
    viewRoutingButton.setTitle(NSLocalizedString("Viewed routes", comment: ""), for: .normal)
    viewRoutingButton.titleLabel?.adjustsFontForContentSizeCategory = true
    profilePhoto.image = #imageLiteral(resourceName: "face")
    profilePhoto.contentMode = .scaleAspectFill
    isGuideImage.isHidden = true
   
    
    //test data
    userCity.text = NSLocalizedString("City", comment: "")
    userLanguages.text = NSLocalizedString("Languages", comment: "")
    userContacts.text = NSLocalizedString("Contacts", comment: "")
    userName.text = "Евгений Уланов"
    cityInfo.text = "Владимир, Россия"
    langInfo.text = "Русский, Английский"
    contactInfo.text = "+79040303551\njeny@ulanoff.ru"
    
    }
    
    private func updateUIForGuide(){
        DispatchQueue.main.async {
            self.isGuideImage.isHidden = false
            self.stayGuideButton.setTitle(NSLocalizedString("Create excursion", comment: ""), for: .normal)
            self.stayGuideButton.backgroundColor = #colorLiteral(red: 1, green: 0.662745098, blue: 0.1294117647, alpha: 1)
        }
    }
    
    override func viewDidLayoutSubviews() {
        profilePhoto.layer.cornerRadius = profilePhoto.frame.height / 2
        //updateUIForGuide()
    }
    
  // MARK: Routing
  

  
  // MARK: View lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupDesign()
  }
  
    @IBAction func unwindToProfile(segue: UIStoryboardSegue){
        
    }
    
  func displayData(viewModel: UserProfile.Model.ViewModel.ViewModelData) {

  }
    @IBAction func becomeGuideButton(_ sender: Any) {
        updateUIForGuide()
    }
    
    @IBAction func viewRoutesButton(_ sender: Any) {
        
    }
    @IBAction func editInfoButPress(_ sender: Any) {
        router?.showEditInfoScene()
    }
    @IBAction func settingButPress(_ sender: Any) {
        router?.showSettingScene()
    }
    
}
