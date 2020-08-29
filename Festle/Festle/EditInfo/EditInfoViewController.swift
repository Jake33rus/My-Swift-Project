//
//  EditInfoViewController.swift
//  Festle
//
//  Created by Евгений Уланов on 02.08.2020.
//  Copyright (c) 2020 Евгений Уланов. All rights reserved.
//

import UIKit
import SwiftEntryKit

protocol EditInfoDisplayLogic: class {
  func displayData(viewModel: EditInfo.Model.ViewModel.ViewModelData)
}

class EditInfoViewController: UIViewController, EditInfoDisplayLogic {
    
    @IBOutlet weak var saveButton: UIButton!{
        didSet{
            saveButton.setTitle(NSLocalizedString("Save", comment: ""), for: .normal)
        }
    }
    @IBOutlet weak var titleLabel: UILabel!{
        didSet{
            titleLabel.text = NSLocalizedString("EditLabel", comment: "")
        }
    }
    @IBOutlet weak var changePhotoButton: UIButton!{
        didSet{
            
        }
    }
    @IBOutlet weak var fNameTF: UITextField!{
        didSet{
            fNameTF.placeholder = EKProperty.LabelContent(text: NSLocalizedString("FirstName", comment: ""), style: .init(font: UIFont.systemFont(ofSize: 14, weight: .thin), color: .init(red: 151, green: 149, blue: 149)))
        }
    }
    @IBOutlet weak var sNameTF: UITextField!{
        didSet{
            sNameTF.placeholder = EKProperty.LabelContent(text: NSLocalizedString("SecondName", comment: ""), style: .init(font: UIFont.systemFont(ofSize: 14, weight: .thin), color: .init(red: 151, green: 149, blue: 149)))
        }
    }
    @IBOutlet weak var userPhoto: UIImageView!{
        didSet{
            userPhoto.layer.cornerRadius = userPhoto.bounds.height / 2
            userPhoto.layer.borderWidth = 1.0
            userPhoto.layer.borderColor = #colorLiteral(red: 0, green: 0.693600595, blue: 0.9541637301, alpha: 1)
            userPhoto.clipsToBounds = true
        }
    }
    @IBOutlet weak var cityTF: UITextField!{
        didSet{
            
        }
    }
    @IBOutlet weak var bdTF: UITextField!{
        didSet{
            
        }
    }
    @IBOutlet weak var langTf: UITextField!{
        didSet{
            
        }
    }
    @IBOutlet weak var aboutMeTV: UITextView!{
        didSet{
            aboutMeTV.layer.borderWidth = 1.0
            aboutMeTV.layer.borderColor = #colorLiteral(red: 0, green: 0.693600595, blue: 0.9541637301, alpha: 1)
            aboutMeTV.layer.cornerRadius = 8
            aboutMeTV.clipsToBounds = true
        }
    }
    @IBOutlet weak var aboutLabel: UILabel!{
        didSet{
            aboutLabel.text = NSLocalizedString("About me", comment: "")
        }
    }
    @IBOutlet weak var langLabel: UILabel!{
        didSet{
            langLabel.text = NSLocalizedString("LanguagesProficiency", comment: "")
        }
    }
    @IBOutlet weak var birthdayLabel: UILabel!{
        didSet{
            birthdayLabel.text = NSLocalizedString("Birthday", comment: "")
        }
    }
    @IBOutlet weak var sexLabel: UILabel!{
        didSet{
            sexLabel.text = NSLocalizedString("Sex", comment: "")
        }
    }
    var interactor: EditInfoBusinessLogic?
  var router: (NSObjectProtocol & EditInfoRoutingLogic)?

    
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
    let interactor            = EditInfoInteractor()
    let presenter             = EditInfoPresenter()
    let router                = EditInfoRouter()
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
  
  func displayData(viewModel: EditInfo.Model.ViewModel.ViewModelData) {

  }
  
    @IBAction func saveButPress(_ sender: Any) {
    }
}
