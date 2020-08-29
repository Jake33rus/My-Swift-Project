//
//  RegistrationViewController.swift
//  Festle
//
//  Created by Евгений Уланов on 26.07.2020.
//  Copyright (c) 2020 Евгений Уланов. All rights reserved.
//

import UIKit
import SwiftEntryKit

protocol RegistrationDisplayLogic: class {
  func displayData(viewModel: Registration.Model.ViewModel.ViewModelData)
}

class RegistrationViewController: UIViewController, RegistrationDisplayLogic {

  var interactor: RegistrationBusinessLogic?
  var router: (NSObjectProtocol & RegistrationRoutingLogic)?

    @IBOutlet weak var signUpLabel: UILabel! {
        didSet{
            signUpLabel.text = NSLocalizedString("Registration", comment: "")
        }
    }
    @IBOutlet weak var loginTextField: UITextField!{
        didSet{
            loginTextField.layer.cornerRadius = 8
            loginTextField.layer.borderWidth = 2.0
            loginTextField.layer.borderColor = #colorLiteral(red: 0.6588235294, green: 0.6745098039, blue: 0.6862745098, alpha: 1)
            loginTextField.clipsToBounds = true
            loginTextField.placeholder = EKProperty.LabelContent(text: NSLocalizedString("Login", comment: ""), style: .init(font: UIFont.systemFont(ofSize: 16, weight: .thin), color: .init(red: 151, green: 149, blue: 149)))
            loginTextField.setLeftPaddingPoints(10)
            loginTextField.setRightPaddingPoints(10)
        }
    }
    @IBOutlet weak var passwordTextField: UITextField!{
        didSet{
            passwordTextField.setLeftView(image: UIImage.init(systemName: "eye")!)
            passwordTextField.isSecureTextEntry = true
            passwordTextField.layer.cornerRadius = 8
            passwordTextField.layer.borderWidth = 2.0
            passwordTextField.layer.borderColor = #colorLiteral(red: 0.6588235294, green: 0.6745098039, blue: 0.6862745098, alpha: 1)
            passwordTextField.clipsToBounds = true
            passwordTextField.placeholder = EKProperty.LabelContent(text: NSLocalizedString("Password", comment: ""), style: .init(font: UIFont.systemFont(ofSize: 16, weight: .thin), color: .init(red: 151, green: 149, blue: 149)))
            passwordTextField.setLeftPaddingPoints(10)
            passwordTextField.setRightPaddingPoints(10)
        }
    }
    
    var passwordImage = UIImage(systemName: "eye")
    
    @IBOutlet weak var nameTextField: UITextField!{
        didSet{
            nameTextField.layer.cornerRadius = 8
            nameTextField.layer.borderWidth = 2.0
            nameTextField.layer.borderColor = #colorLiteral(red: 0.6588235294, green: 0.6745098039, blue: 0.6862745098, alpha: 1)
            nameTextField.clipsToBounds = true
            nameTextField.placeholder = EKProperty.LabelContent(text: NSLocalizedString("Name", comment: ""), style: .init(font: UIFont.systemFont(ofSize: 16, weight: .thin), color: .init(red: 151, green: 149, blue: 149)))
            nameTextField.setLeftPaddingPoints(10)
            nameTextField.setRightPaddingPoints(10)
        }
    }
    @IBOutlet weak var cityTextField: UITextField!{
        didSet{
            cityTextField.layer.cornerRadius = 8
            cityTextField.layer.borderWidth = 2.0
            cityTextField.layer.borderColor = #colorLiteral(red: 0.6588235294, green: 0.6745098039, blue: 0.6862745098, alpha: 1)
            cityTextField.clipsToBounds = true
            cityTextField.placeholder = EKProperty.LabelContent(text: NSLocalizedString("City", comment: ""), style: .init(font: UIFont.systemFont(ofSize: 16, weight: .thin), color: .init(red: 151, green: 149, blue: 149)))
            cityTextField.setLeftPaddingPoints(10)
            cityTextField.setRightPaddingPoints(10)
        }
    }
    @IBOutlet weak var emailTextField: UITextField!{
        didSet{
            emailTextField.layer.cornerRadius = 8
            emailTextField.layer.borderWidth = 2.0
            emailTextField.layer.borderColor = #colorLiteral(red: 0.6588235294, green: 0.6745098039, blue: 0.6862745098, alpha: 1)
            emailTextField.clipsToBounds = true
            emailTextField.placeholder = EKProperty.LabelContent(text: NSLocalizedString("Email", comment: ""), style: .init(font: UIFont.systemFont(ofSize: 16, weight: .thin), color: .init(red: 151, green: 149, blue: 149)))
            emailTextField.setLeftPaddingPoints(10)
            emailTextField.setRightPaddingPoints(10)
        }
    }
    @IBOutlet weak var telnumbTextField: UITextField!{
        didSet{
            telnumbTextField.layer.cornerRadius = 8
            telnumbTextField.layer.borderWidth = 2.0
            telnumbTextField.layer.borderColor = #colorLiteral(red: 0.6588235294, green: 0.6745098039, blue: 0.6862745098, alpha: 1)
            telnumbTextField.clipsToBounds = true
            telnumbTextField.placeholder = EKProperty.LabelContent(text: NSLocalizedString("Telnumb", comment: ""), style: .init(font: UIFont.systemFont(ofSize: 16, weight: .thin), color: .init(red: 151, green: 149, blue: 149)))
            telnumbTextField.setLeftPaddingPoints(10)
            telnumbTextField.setRightPaddingPoints(10)
        }
    }
    @IBOutlet weak var signUpButton: UIButton!{
        didSet{
            signUpButton.setTitle(NSLocalizedString("SignUpButton", comment: ""), for: .normal)
            signUpButton.layer.cornerRadius = 8
            signUpButton.layer.borderWidth = 2.0
            signUpButton.layer.borderColor = #colorLiteral(red: 0, green: 0.693600595, blue: 0.9541637301, alpha: 1)
            signUpButton.clipsToBounds = true
        }
    }
    @IBOutlet weak var privacyInfoLabel: UILabel!{
        didSet{
            privacyInfoLabel.text = NSLocalizedString("Privacy Info", comment: "")
        }
    }
    @IBOutlet weak var viaLabel: UILabel!{
        didSet{
            viaLabel.text = NSLocalizedString("ViaLabel", comment: "")
        }
    }
    @IBOutlet weak var privacyButtom: UIButton!{
        didSet {
            privacyButtom.setTitle(NSLocalizedString("Privacy button", comment: ""), for: .normal)
        }
    }
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
    let interactor            = RegistrationInteractor()
    let presenter             = RegistrationPresenter()
    let router                = RegistrationRouter()
    viewController.interactor = interactor
    viewController.router     = router
    interactor.presenter      = presenter
    presenter.viewController  = viewController
    router.viewController     = viewController
  }
  
  // MARK: Routing
  
    @IBAction func signUpTapped(_ sender: Any) {
        guard let email = emailTextField.text else { return }
        guard let nickname = loginTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        let regModel = RegisterModel(email: email, nickname: nickname, password: password, platform: "iOS")
        let loginProvider = NetworkManager<LoginProvider>()
        loginProvider.request(service: .register(regModel: regModel), decodeType: (AuthResponse.self)) { (result) in
            switch result{
            case .success(let response):
                let tokens = response.accessToken
                print("accessToken:\(response.accessToken)\nrefreshToken:\(response.refreshToken)")
            case .failure(let error):
                print(error)
            }
        }
        
    }
    @IBAction func privacyTapped(_ sender: Any) {
    }
    @IBAction func vkSignUpTapped(_ sender: Any) {
    }
    @IBAction func facebookTapped(_ sender: Any) {
    }
    @IBAction func outTap(_ sender: Any) {
        loginTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        cityTextField.resignFirstResponder()
        telnumbTextField.resignFirstResponder()
        nameTextField.resignFirstResponder()
        emailTextField.resignFirstResponder()
    }
    
  
  // MARK: View lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  func displayData(viewModel: Registration.Model.ViewModel.ViewModelData) {

  }
  
}
