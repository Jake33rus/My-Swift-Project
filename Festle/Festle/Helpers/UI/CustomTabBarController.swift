//
//  CustomTabBarController.swift
//  Festle
//
//  Created by Евгений Уланов on 03.08.2020.
//  Copyright © 2020 Евгений Уланов. All rights reserved.
//

import UIKit
import BATabBarController

class CustomTabBarController: UIViewController, BATabBarControllerDelegate{
    func tabBarController(_ tabBarController: BATabBarController, didSelect: UIViewController) {
        print("Delegate success!");
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        let vc1 = UIViewController()
        let vc2 = UIViewController()
        let vc3 = UIViewController()

        let option1 = NSMutableAttributedString(string: "Feed")
        option1.addAttribute(.foregroundColor, value: UIColor.white, range: NSRange(location: 0, length: option1.length))
        let tabBarItem  = BATabBarItem(image: UIImage(named: "first")!, selectedImage: UIImage(named: "first_sel")!, title: option1)
        let tabBarItem2 = BATabBarItem(image: UIImage(named: "second")!, selectedImage: UIImage(named: "second_sel")!, title: option1)
        let tabBarItem3 = BATabBarItem(image: UIImage(named: "third")!, selectedImage: UIImage(named: "third_sel")!, title: option1)


        let baTabBarController = BATabBarController()
        baTabBarController.viewControllers = [vc1, vc2, vc3]
        baTabBarController.tabBarItems = [tabBarItem, tabBarItem2, tabBarItem3]
        baTabBarController.delegate = self
        self.view.addSubview(baTabBarController.view)
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
