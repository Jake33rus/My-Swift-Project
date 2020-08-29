//
//  CreateTourViewController.swift
//  Festle
//
//  Created by Евгений Уланов on 23.08.2020.
//  Copyright (c) 2020 Евгений Уланов. All rights reserved.
//

import UIKit

protocol CreateTourDisplayLogic: class {
  func displayData(viewModel: CreateTourModels.Model.ViewModel.ViewModelData)
}

class CreateTourViewController: UIViewController, CreateTourDisplayLogic {

  var interactor: CreateTourBusinessLogic?
  var router: (NSObjectProtocol & CreateTourRoutingLogic)?

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
    let interactor            = CreateTourInteractor()
    let presenter             = CreateTourPresenter()
    let router                = CreateTourRouter()
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
  }
  
  func displayData(viewModel: CreateTourModels.Model.ViewModel.ViewModelData) {

  }
  
}
