//
//  AuthPopUpView.swift
//  Festle
//
//  Created by Евгений Уланов on 05.07.2020.
//  Copyright © 2020 Евгений Уланов. All rights reserved.
//

import UIKit
import SwiftEntryKit

class AuthPopUpView: UIView {
    
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let buttonVK = ButtonWithImage()
    private let buttonFacebook = ButtonWithImage()
    private let buttonGoogle = ButtonWithImage()
    private let buttonApple = ButtonWithImage()
    
    
    private let message: EKAuthPopUp
    
    init(with message: EKAuthPopUp) {
        self.message = message
        super.init(frame: UIScreen.main.bounds)
        
        setupElements()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    @objc func vkButtonPressed(){
        message.actionVK()
    }
    @objc func googleButtonPressed(){
        message.actionGoogle()
    }
    @objc func facebookButtonPressed(){
        message.actionFacebook()
    }
    @objc func appleButtonPressed(){
        message.actionApple()
    }
}

// MARK: - Setup View
extension AuthPopUpView {
    func setupElements() {
        titleLabel.content = message.title
        descriptionLabel.content = message.description
        buttonVK.buttonContent = message.buttonVK
        buttonFacebook.buttonContent = message.buttonFacebook
        buttonGoogle.buttonContent = message.buttonGoogle
        buttonApple.buttonContent = message.buttonApple
        
        let logoVK : UIImage = UIImage(named: "vk")!
        let logoFacebook : UIImage = UIImage(named: "facebook")!
        let logoGoogle : UIImage = UIImage(named: "google")!
        let logoApple : UIImage = UIImage(named: "apple")!
        let vkIV = UIImageView(image: logoVK)
        vkIV.frame = .init(x: 10, y: 7.5, width: 30, height: 30)
        let facebookIV = UIImageView(image: logoFacebook)
         facebookIV.frame = .init(x: 10, y: 7.5, width: 30, height: 30)
        let googleIV = UIImageView(image: logoGoogle)
         googleIV.frame = .init(x: 10, y: 7.5, width: 30, height: 30)
        let appleIV = UIImageView(image: logoApple)
         appleIV.frame = .init(x: 10, y: 7.5, width: 30, height: 30)
        
        buttonVK.addTarget(self, action: #selector(vkButtonPressed), for: .touchUpInside)
        buttonVK.addSubview(vkIV)
        buttonFacebook.addTarget(self, action: #selector(facebookButtonPressed), for: .touchUpInside)
        buttonFacebook.addSubview(facebookIV)
        buttonGoogle.addTarget(self, action: #selector(googleButtonPressed), for: .touchUpInside)
        buttonGoogle.addSubview(googleIV)
        buttonApple.addTarget(self, action: #selector(appleButtonPressed), for: .touchUpInside)
        buttonApple.addSubview(appleIV)
    }
}



// MARK: - Setup Constraints
extension AuthPopUpView {
    func setupConstraints(){
        addSubview(titleLabel)
        titleLabel.layoutToSuperview(.centerX)
        titleLabel.layoutToSuperview(.top, offset:20)
        
        addSubview(descriptionLabel)
        descriptionLabel.layoutToSuperview(axis: .horizontally, offset: 30)
        descriptionLabel.layout(.top, to: .bottom, of: titleLabel, offset: 20)
        descriptionLabel.forceContentWrap(.vertically)
        
        addSubview(buttonVK)
        let height: CGFloat = 45
        buttonVK.set(.width, of: 350)
        buttonVK.set(.height, of: height)
        buttonVK.layout(.top, to: .bottom, of: descriptionLabel, offset:20)
        buttonVK.layoutToSuperview(.centerX)
        let buttonAttributes = message.buttonVK
        buttonVK.buttonContent = buttonAttributes
        buttonVK.contentEdgeInsets = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30)
        buttonVK.layer.cornerRadius = height * 0.3
        
        addSubview(buttonFacebook)
        buttonFacebook.set(.height, of: 45)
        buttonFacebook.set(.width, of: 350)
        buttonFacebook.layout(.top, to: .bottom, of: buttonVK, offset:20)
        buttonFacebook.layoutToSuperview(.centerX)
        let buttonAttributesFacebook = message.buttonFacebook
        buttonFacebook.buttonContent = buttonAttributesFacebook
        buttonFacebook.contentEdgeInsets = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30)
        buttonFacebook.layer.cornerRadius = height * 0.3
        
        addSubview(buttonGoogle)
        buttonGoogle.set(.height, of: height)
        buttonGoogle.set(.width, of: 350)
        buttonGoogle.layout(.top, to: .bottom, of: buttonFacebook, offset:20)
        buttonGoogle.layoutToSuperview(.centerX)
        let buttonAttributesGoogle = message.buttonGoogle
        buttonGoogle.buttonContent = buttonAttributesGoogle
        buttonGoogle.contentEdgeInsets = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30)
        buttonGoogle.layer.cornerRadius = height * 0.3
        
        addSubview(buttonApple)
        buttonApple.set(.height, of: height)
        buttonApple.set(.width, of: 350)
        buttonApple.layout(.top, to: .bottom, of: buttonGoogle, offset:20)
        buttonApple.layoutToSuperview(.centerX)
        buttonApple.layoutToSuperview(.bottom, offset: -30)
        let buttonAttributesApple = message.buttonApple
        buttonApple.buttonContent = buttonAttributesApple
        buttonApple.contentEdgeInsets = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30)
        buttonApple.layer.cornerRadius = height * 0.3
    }
}
