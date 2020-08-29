//
//  likeViewController.swift
//  Festle
//
//  Created by Евгений Уланов on 12.07.2020.
//  Copyright (c) 2020 Евгений Уланов. All rights reserved.
//

import UIKit

protocol likeDisplayLogic: class {
  func displayData(viewModel: like.Model.ViewModel.ViewModelData)
}

class likeViewController: UIViewController, likeDisplayLogic {

  var interactor: likeBusinessLogic?
  var router: (NSObjectProtocol & likeRoutingLogic)?

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
    let interactor            = likeInteractor()
    let presenter             = likePresenter()
    let router                = likeRouter()
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
  
  func displayData(viewModel: like.Model.ViewModel.ViewModelData) {

  }
  
}
