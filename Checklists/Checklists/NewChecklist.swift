//
//  NewChecklist.swift
//  Checklists
//
//  Created by Евгений Уланов on 26.09.2020.
//

import UIKit

class NewChecklist: UIViewController {

    @IBOutlet var radioButtons: [RadioButton]!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameTF: UITextField!{
        didSet{
            nameTF.layer.borderWidth = 1
            nameTF.layer.borderColor = #colorLiteral(red: 0.4513868093, green: 0.9930960536, blue: 1, alpha: 1)
            nameTF.layer.cornerRadius = 15
            nameTF.clipsToBounds = true
            nameTF.frame.size.height = 40
        }
    }
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var descTextField: UITextView!{
        didSet{
            descTextField.layer.borderWidth = 1
            descTextField.layer.borderColor = #colorLiteral(red: 0.4513868093, green: 0.9930960536, blue: 1, alpha: 1)
            descTextField.layer.cornerRadius = 15
            descTextField.clipsToBounds = true
        }
    }
    @IBOutlet weak var iconLabel: UILabel!
    @IBOutlet weak var addNewIcon: UIButton!
    @IBOutlet weak var iconCollections: UICollectionView!{
        didSet{
            iconCollections.layer.borderWidth = 1
            iconCollections.layer.borderColor = #colorLiteral(red: 0.4513868093, green: 0.9930960536, blue: 1, alpha: 1)
            iconCollections.layer.cornerRadius = 15
        }
    }
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!{
        didSet{
            saveButton.layer.cornerRadius = saveButton.frame.height/2
            saveButton.layer.shadowOpacity = 0.15
            saveButton.layer.shadowOffset = .zero
            saveButton.layer.shadowColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            saveButton.layer.shadowRadius = 20
            saveButton.layer.shadowPath = UIBezierPath(rect: saveButton.bounds).cgPath
        }
    }
    
    var icons:[UIImage] = Emojies(size: 50).emojies
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.layer.borderColor = #colorLiteral(red: 0.4513868093, green: 0.9930960536, blue: 1, alpha: 1)
        self.view.layer.borderWidth = 1
        self.view.layer.cornerRadius = 50
    }
    

    @IBAction func radioButtonPress(_ sender: RadioButton) {
        sender.isSelected = !sender.isSelected
        for button in radioButtons{
            if button != sender{
                button.isSelected = false
            }
        }
    }
    @IBAction func addNewIconPress(_ sender: Any) {
        let alertController: UIAlertController = UIAlertController(title: "Добавить иконку",
                                                                   message: "Введите один смайлик",
                                                                   preferredStyle: .alert)
        
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
            //cancel code
        }
        alertController.addAction(cancelAction)
        
        let nextAction: UIAlertAction = UIAlertAction(title: "Добавить", style: .default) { [weak self] action -> Void in
            if let text = (alertController.textFields?.first!)?.text{
                self?.icons.append(text.image(resize: 40)!)
                self?.iconCollections.reloadData()
                self?.iconCollections?.selectItem(at: IndexPath(row: (self?.icons.count)!-1, section: 0),
                                                  animated: true,
                                                  scrollPosition: .left)
            }
        }
        alertController.addAction(nextAction)
        alertController.addTextField { (textField) -> Void in
            textField.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            textField.backgroundColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
        }
        self.present(alertController, animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension NewChecklist: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        icons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        let cell = iconCollections.cellForItem(at: indexPath) as! IconCell
        cell.layer.cornerRadius = 10
        cell.layer.borderWidth = 1
        cell.layer.borderColor = #colorLiteral(red: 0.4513868093, green: 0.9930960536, blue: 1, alpha: 1)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = iconCollections.dequeueReusableCell(withReuseIdentifier: "iconCell", for: indexPath) as! IconCell
        cell.iconImage.image = icons[indexPath.row]
        cell.layer.cornerRadius = 10
        return cell
    }
}
