//
//  DetailViewControllerTests.swift
//  ToDoApp(UnitTests)Tests
//
//  Created by Евгений Уланов on 13.10.2020.
//  Copyright © 2020 Евгений Уланов. All rights reserved.
//

import XCTest
import CoreLocation
@testable import ToDoApp_UnitTests_

class DetailViewControllerTests: XCTestCase {

    var sut: DetailViewController!
    
    override func setUpWithError() throws {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(identifier: String(describing:
            DetailViewController.self)) as? DetailViewController
        sut.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testHasTitleLabel(){
        XCTAssertNotNil(sut.titleLabel)
        XCTAssertTrue(sut.titleLabel.isDescendant(of: sut.view))
    }
    
    func testHasDescriptionLabelLabel(){
        XCTAssertNotNil(sut.descriptionLabel)
        XCTAssertTrue(sut.descriptionLabel.isDescendant(of: sut.view))
    }
    
    func testHasDateLabelLabel(){
        XCTAssertNotNil(sut.dateLabel)
        XCTAssertTrue(sut.dateLabel.isDescendant(of: sut.view))
    }
    
    func testHasLocationLabelLabel(){
        XCTAssertNotNil(sut.locationLabel)
        XCTAssertTrue(sut.locationLabel.isDescendant(of: sut.view))
    }
    
    
    func testHasMapView(){
        XCTAssertNotNil(sut.mapView)
        XCTAssertTrue(sut.mapView.isDescendant(of: sut.view))
    }
    
    func setupTaskAndApperanceTransition(){
        let coordinate = CLLocationCoordinate2D(latitude: 56.12173997, longitude: 40.35858478)
        let location = Location(name: "Baz", coordinate: coordinate)
        let date = Date(timeIntervalSince1970: 1601510400)
        let task = Task(title: "Foo", description: "Bar", date: date, location: location)
        sut.task = task
        
        sut.beginAppearanceTransition(true, animated: true)
        sut.endAppearanceTransition()
    }
    
    func testSettingTaskSetsTitleLabel(){
        setupTaskAndApperanceTransition()
        XCTAssertEqual(sut.titleLabel.text, "Foo")
    }
    
    func testSettingTaskSetsDescriptionLabel(){
        setupTaskAndApperanceTransition()
        XCTAssertEqual(sut.descriptionLabel.text, "Bar")
    }
    
    func testSettingTaskSetsLocationLabel(){
        setupTaskAndApperanceTransition()
        XCTAssertEqual(sut.locationLabel.text, "Baz")
    }
    
    func testSettingTaskSetsDateLabel(){
        setupTaskAndApperanceTransition()
        XCTAssertEqual(sut.dateLabel.text, "01.10.20")
    }
    
    func testSettingTaskSetsMapView(){
        setupTaskAndApperanceTransition()
        XCTAssertEqual(sut.mapView.centerCoordinate.latitude,56.12173997, accuracy: 0.001)
        XCTAssertEqual(sut.mapView.centerCoordinate.longitude,40.35858478, accuracy: 0.001)
    }
}
