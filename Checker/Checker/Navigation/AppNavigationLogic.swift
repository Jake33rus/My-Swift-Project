//
//  AppNavigationLogic.swift
//  Checker
//
//  Created by Евгений Уланов on 27.03.2021.
//

import UIKit

enum CheckerNavigation: Navigation {
    case mainPage
    case newCheckList
    case yourCheckList
    case openedCheckList
    case exampleCheckList
}

struct CheckerAppNavigation: AppNavigation {
    func viewcontrollerForNavigation(navigation: Navigation) -> UIViewController {
        if let navigation = navigation as? CheckerNavigation {
            switch navigation {
            case .mainPage:
                return MainPageView()
            case .newCheckList:
                return NewCheckListView()
            case .yourCheckList:
                return YourCheckListsView()
            case .openedCheckList:
                return OpenCheckListView()
            case .exampleCheckList:
                return ExampleCheckListView()
            }
        }
        return UIViewController()
    }
    
    func navigate(_ navigation: Navigation, from: UIViewController, to: UIViewController) {
        from.navigationController?.pushViewController(to, animated: true)
    }
}
