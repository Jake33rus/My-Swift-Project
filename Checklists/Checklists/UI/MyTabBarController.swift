//
//  MyTabBarController.swift
//  Checklists
//
//  Created by Евгений Уланов on 29.09.2020.
//

import UIKit
import STTabbar

class MyTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        if let myTabbar = tabBar as? STTabbar {
                   myTabbar.centerButtonActionHandler = {
                        self.performSegue(withIdentifier: "newChecklist", sender: nil)
                   }
               }
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
