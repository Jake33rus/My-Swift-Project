//
//  LoginViewController.swift
//  Festle
//
//  Created by Евгений Уланов on 05.07.2020.
//  Copyright (c) 2020 Евгений Уланов. All rights reserved.
//

import UIKit
import SwiftEntryKit

protocol LoginDisplayLogic: class {
  func displayData(viewModel: Login.Model.ViewModel.ViewModelData)
}

class LoginViewController: UIViewController, LoginDisplayLogic {
    
    let selfToRegistrationSegueName = "LoginToRegistrationSegue"
    let selfToMainSegueName = "LoginToMainSegue"

    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var registrationButton: UIButton!
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
    @IBOutlet weak var passwordTextField: UITextField! {
        didSet {
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
    
    @IBAction func tap(_ sender: Any) {
        loginTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
    

    var interactor: LoginBusinessLogic?
  var router: (NSObjectProtocol & LoginRoutingLogic)?

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
    let interactor            = LoginInteractor()
    let presenter             = LoginPresenter()
    let router                = LoginRouter()
    viewController.interactor = interactor
    viewController.router     = router
    interactor.presenter      = presenter
    presenter.viewController  = viewController
    router.viewController     = viewController
  }
    
  // MARK: Design Setup
    private func setupDesign(){
        
        //setup registration button
        registrationButton.layer.cornerRadius = 8
        registrationButton.layer.borderWidth = 2.0
        registrationButton.layer.borderColor = #colorLiteral(red: 0, green: 0.693600595, blue: 0.9541637301, alpha: 1)
        registrationButton.clipsToBounds = true
        registrationButton.setTitle(NSLocalizedString("Registration", comment: ""), for: .normal)
        
        
         //setup sign in button
        signInButton.layer.cornerRadius = 8
        signInButton.layer.borderWidth = 2.0
        signInButton.layer.borderColor = #colorLiteral(red: 0, green: 0.693600595, blue: 0.9541637301, alpha: 1)
        signInButton.clipsToBounds = true
        signInButton.setTitle(NSLocalizedString("Sign in", comment: ""), for: .normal)
        
    }
    
  // MARK: Routing
  

  
  // MARK: View lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    loginTextField.delegate = self
    passwordTextField.delegate = self
    setupDesign()
  }
    
  
  func displayData(viewModel: Login.Model.ViewModel.ViewModelData) {

  }
    
    private func setupPopUpMessage() -> EKAuthPopUp{
        let title = "Войти с помощью"
        let description = "Авторизируйтесь через доверенные сервисы"
       // let image = UIImage(named: "logo2.1")!.withRenderingMode(.alwaysTemplate)
        
        let titleLabel = EKProperty.LabelContent(text: title,
                                                 style: .init(font: UIFont.systemFont(ofSize: 16),
                                                                      color: .black,
                                                                      alignment: .center))
        
        let descriptionLabel = EKProperty.LabelContent(text: description,
        style: .init(font: UIFont.systemFont(ofSize: 14),
                             color: .black,
                             alignment: .center))
        
        let buttonVK = EKProperty.ButtonContent(label: .init(text: "Авторизоваться через VK",
                                                             style: .init(font: UIFont.systemFont(ofSize: 16),
                                                                          color: .white)),
                                                backgroundColor: .init(#colorLiteral(red: 0.3176470588, green: 0.5058823529, blue: 0.7215686275, alpha: 1)),
                                                highlightedBackgroundColor: .clear)
        
        let buttonGoogle = EKProperty.ButtonContent(label: .init(text: "Авторизоваться через Google",
                                                             style: .init(font: UIFont.systemFont(ofSize: 16),
                                                                          color: .black)),
                                                backgroundColor: .init(UIColor.white),
                                                highlightedBackgroundColor: .clear)
        
        let buttonFacebook = EKProperty.ButtonContent(label: .init(text: "Авторизоваться через Facebook",
                                                             style: .init(font: UIFont.systemFont(ofSize: 16),
                                                                          color: .white)),
                                                backgroundColor: .init(#colorLiteral(red: 0.03529411765, green: 0.01568627451, blue: 0.7647058824, alpha: 1)),
                                                highlightedBackgroundColor: .clear)
        
        let buttonApple = EKProperty.ButtonContent(label: .init(text: "Авторизоваться через Apple",
                                                             style: .init(font: UIFont.systemFont(ofSize: 16),
                                                                          color: .white)),
                                                backgroundColor: .init(UIColor.black),
                                                highlightedBackgroundColor: .clear)
        
        let message = EKAuthPopUp(themeImage: nil,
                                  title: titleLabel,
                                  description: descriptionLabel,
                                  buttonVK: buttonVK,
                                  buttonGoogle: buttonGoogle,
                                  buttonFacebook: buttonFacebook,
                                  buttonApple: buttonApple,
                                  actionVK: {
                                    print("vk")},
                                  actionGoogle: {
                                    print("google")},
                                  actionFacebook: {
                                    print("facebook")
                                    self.interactor?.authFacebook(loginVC: self)},
                                  actionApple: {
                                    print("apple")
                                })
        return message
    }
    
    func setupPopUpAttributes() -> EKAttributes {
        var attributes = EKAttributes.bottomToast
        attributes.displayDuration = .infinity
        attributes.screenBackground = .color(color: .init(light: UIColor(white: 100.0/255.0,
                                                                         alpha: 0.3),
                                                          dark: UIColor(white: 50.0/255.0,
                                                                        alpha: 0.3)))
        attributes.shadow = .active(with: .init(color: .black,
                                                opacity: 0.3,
                                                radius: 8))
        
        attributes.entryBackground = .color(color: .init(red: 0, green: 160, blue: 240))
        attributes.roundCorners = .top(radius: 40)
        attributes = .bottomNote
        attributes.border = .value(color: #colorLiteral(red: 1, green: 0.662745098, blue: 0.1294117647, alpha: 1), width: 2)
        attributes.entryBackground = .visualEffect(style: .standard)
        attributes.scroll = .enabled(swipeable: true,
                                     pullbackAnimation: .jolt)
        attributes.entranceAnimation = .init(
            translate: .init(duration: 0.7,
                             spring: .init(damping: 1,
                                           initialVelocity: 0)),
            scale: .init(from: 1.05,
                         to: 1,
                         duration: 0.4,
                         spring: .init(damping: 1,
                                       initialVelocity: 0)
            )
        )
        
        attributes.exitAnimation = .init(translate: .init(duration: 0.2))
        attributes.popBehavior = .animated(animation: .init(translate: .init(duration: 0.2)))
        attributes.roundCorners = .top(radius: 40)
        return attributes
    }
    
    @IBAction func signInButtonPressed(_ sender: Any) {
        guard let login = loginTextField.text else {return}
        guard let password = passwordTextField.text else {return}
        let loginModel = LoginModel(login: login, password: password, platform: "iOS")
        self.interactor?.makeRequest(request: .baseLogIn(model: loginModel))
        router?.showMainScene()
    }
    
    @IBAction func registrationButtonPressed(_ sender: Any) {
        router?.showRegistrationScene()
    }
    
    @IBAction func otherOptionButtonPressed(_ sender: Any) {
        SwiftEntryKit.display(entry: AuthPopUpView(with: self.setupPopUpMessage()), using: setupPopUpAttributes())
    }
    @IBAction func unwindToLoginVC(segue: UIStoryboardSegue) {}
}

extension LoginViewController: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == loginTextField {
            textField.resignFirstResponder()
            passwordTextField.becomeFirstResponder()
        }
        else {
            self.view.endEditing(true)
        }
        return false
    }
    
    func textFieldDidChange() {
        if passwordTextField.text != "" {
            
        }
    }


    @objc func togglePasswordSecurity() {

        if passwordTextField.isSecureTextEntry == false {

            passwordImage = UIImage(systemName: "eye")
            textFieldDidChange()

            // change left UIImage to hide_password
            passwordTextField.isSecureTextEntry = true
        }else{

            passwordImage = UIImage(systemName: "eye.slash")
            self.textFieldDidChange()
            // change left UIImage to view_password
            passwordTextField.isSecureTextEntry = false
        }
    }
}

extension UITextField {
    
  func setLeftView(image: UIImage) {
    let iconView = UIImageView(frame: CGRect(x: -5, y: 5, width: 30, height: 30))
    iconView.contentMode = .scaleAspectFit
    iconView.image = image
    let tap = UITapGestureRecognizer(target: self, action: #selector(tappedEye))
    iconView.addGestureRecognizer(tap)
    iconView.isUserInteractionEnabled = true
    let iconContainerView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
    iconContainerView.addSubview(iconView)
    rightView = iconContainerView
    rightViewMode = .whileEditing
    self.tintColor = #colorLiteral(red: 0, green: 0.693600595, blue: 0.9541637301, alpha: 1)
  }
    
    @objc func tappedEye(){
        if self.isSecureTextEntry {
            setLeftView(image: UIImage.init(systemName: "eye.slash")!)
            self.isSecureTextEntry = false
        }
        else {
            setLeftView(image: UIImage.init(systemName: "eye")!)
            self.isSecureTextEntry = true
        }
        
    }
    
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}
