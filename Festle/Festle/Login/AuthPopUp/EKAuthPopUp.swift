//
//  EKAuthPopUp.swift
//  Festle
//
//  Created by Евгений Уланов on 05.07.2020.
//  Copyright © 2020 Евгений Уланов. All rights reserved.
//

import UIKit
import SwiftEntryKit

public struct EKAuthPopUp{
    
    /** Code block that is executed as the user taps the popup button */
    public typealias EKAuthPopUpActionVK = () -> ()
    public typealias EKAuthPopUpActionGoogle = () -> ()
    public typealias EKAuthPopUpActionFacebook = () -> ()
    public typealias EKAuthPopUpActionApple = () -> ()
    
    /** Popup theme image */
    public struct ThemeImage {
        
        /** Position of the theme image */
        public enum Position {
            case topToTop(offset: CGFloat)
            case centerToTop(offset: CGFloat)
        }
        
        /** The content of the image */
        public var image: EKProperty.ImageContent
        
        /** The psotion of the image */
        public var position: Position
        
        /** Initializer */
        public init(image: EKProperty.ImageContent,
                    position: Position = .topToTop(offset: 40)) {
            self.image = image
            self.position = position
        }
    }
    
    public var themeImage: ThemeImage?
    public var title: EKProperty.LabelContent
    public var description: EKProperty.LabelContent
    public var buttonVK: EKProperty.ButtonContent
    public var buttonGoogle: EKProperty.ButtonContent
    public var buttonFacebook: EKProperty.ButtonContent
    public var buttonApple: EKProperty.ButtonContent
    public var actionVK: EKAuthPopUpActionVK
    public var actionGoogle: EKAuthPopUpActionGoogle
    public var actionFacebook: EKAuthPopUpActionFacebook
    public var actionApple: EKAuthPopUpActionApple
    
    var containsImage: Bool {
        return themeImage != nil
    }
    
    public init(themeImage: ThemeImage? = nil,
                title: EKProperty.LabelContent,
                description: EKProperty.LabelContent,
                buttonVK: EKProperty.ButtonContent,
                buttonGoogle: EKProperty.ButtonContent,
                buttonFacebook: EKProperty.ButtonContent,
                buttonApple: EKProperty.ButtonContent,
                actionVK: @escaping EKAuthPopUpActionVK,
                actionGoogle: @escaping EKAuthPopUpActionGoogle,
                actionFacebook: @escaping EKAuthPopUpActionFacebook,
                actionApple: @escaping EKAuthPopUpActionApple) {
        
        self.themeImage = themeImage
        self.title = title
        self.description = description
        self.buttonVK = buttonVK
        self.buttonGoogle = buttonGoogle
        self.buttonFacebook = buttonFacebook
        self.buttonApple = buttonApple
        self.actionVK = actionVK
        self.actionGoogle = actionGoogle
        self.actionFacebook = actionFacebook
        self.actionApple = actionApple
    }
}
