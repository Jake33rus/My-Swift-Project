//
//  ViewController.swift
//  MyToDo(Firebase)
//
//  Created by Евгений Уланов on 04.05.2020.
//  Copyright © 2020 Евгений Уланов. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginViewController: UIViewController {

    let segueIdentifire = "tasksSegue"
    var ref:DatabaseReference!
    
    
    @IBOutlet weak var warnLabel: UILabel!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference(withPath: "users")
        NotificationCenter.default.addObserver(self, selector: #selector(kbDidShow), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(kbDidHide), name: UIResponder.keyboardDidHideNotification, object: nil)
        warnLabel.alpha = 0
        
        Auth.auth().addStateDidChangeListener({ [weak self] (auth, user) in
            if user != nil {
                self?.performSegue(withIdentifier: (self?.segueIdentifire)!, sender: nil)
            }
        })
    }

    @objc func kbDidShow(notification: Notification) {
        guard let userInfo = notification.userInfo else { return }
        let kbFrameSize = (userInfo[UIResponder.keyboardFrameEndUserInfoKey]  as! NSValue).cgRectValue
        
        (self.view as! UIScrollView).contentSize = CGSize(width: self.view.bounds.size.width, height: self.view.bounds.size.height + kbFrameSize.height)
        
        (self.view as! UIScrollView).scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: kbFrameSize.height, right: 0)
    }
    
    @objc func kbDidHide() {
        (self.view as! UIScrollView).contentSize = CGSize(width: self.view.bounds.size.width, height: self.view.bounds.size.height)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        emailTF.text = ""
        passwordTF.text = ""
    }
    
    func displayWarningLabel(withText text:String){
        warnLabel.text = text
        UIView.animate(withDuration: 3, delay:0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            [weak self] in self?.warnLabel.alpha = 1
        }) { [weak self] complite in
            self?.warnLabel.alpha = 0}
    }
    
    @IBAction func loginTapped(_ sender: Any) {
        guard let email = emailTF.text, let password = passwordTF.text, email != "", password != "" else {
            displayWarningLabel(withText: "Info is incorrect")
            return
        }
        Auth.auth().signIn(withEmail: email, password: password, completion: { [weak self] (user, error) in
            if error != nil {
                self?.displayWarningLabel(withText: "Error occured")
                return
            }
            if user != nil {
                self?.performSegue(withIdentifier: (self?.segueIdentifire)!, sender: nil)
                return
            }
            self?.displayWarningLabel(withText: "No such user")
        })
    }
   
    @IBAction func registerTapped(_ sender: Any) {
        guard let email = emailTF.text, let password = passwordTF.text, email != "", password != "" else {
            displayWarningLabel(withText: "Info is incorrect")
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password, completion: { [weak self] (authResult, error) in
            
            guard error == nil, let user = authResult?.user else {
                
                print(error!.localizedDescription)
                return
            }
            
            let userRef = self?.ref.child(user.uid)
            userRef?.setValue(["email": user.email])
        })
    }
    
}

