//
//  ToDoAppTests.swift
//  ToDoApp(UnitTests)Tests
//
//  Created by Евгений Уланов on 15.10.2020.
//  Copyright © 2020 Евгений Уланов. All rights reserved.
//

import XCTest
@testable import ToDoApp_UnitTests_

class ToDoAppTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testInitialViewControllerTaskListViewController(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let navigationContriller = storyboard.instantiateInitialViewController() as! UINavigationController
        let rootViewController = navigationContriller.viewControllers.first as! TaskListViewController
        
        XCTAssertTrue(rootViewController is TaskListViewController)
    }
    
    

}
