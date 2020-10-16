//
//  NewTaskViewControllerTests.swift
//  ToDoApp(UnitTests)Tests
//
//  Created by Евгений Уланов on 13.10.2020.
//  Copyright © 2020 Евгений Уланов. All rights reserved.
//

import XCTest
import CoreLocation
@testable import ToDoApp_UnitTests_

class NewTaskViewControllerTests: XCTestCase {

    var sut: NewTaskViewController!
    var placemark: MockCLPlacemark!
    
    override func setUpWithError() throws {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: String(describing: NewTaskViewController.self)) as? NewTaskViewController
        sut.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testHasTitleTextField(){
        XCTAssertTrue(sut.titleTextField.isDescendant(of: sut.view))
    }
    
    func testHasLocationTextField(){
        XCTAssertTrue(sut.locationTextField.isDescendant(of: sut.view))
    }
    
    func testHasDateTextField(){
        XCTAssertTrue(sut.dateTextField.isDescendant(of: sut.view))
    }
    
    func testHasAddressTextField(){
        XCTAssertTrue(sut.addressTextField.isDescendant(of: sut.view))
    }
    
    func testHasDescriptionTextField(){
        XCTAssertTrue(sut.descriptionTextField.isDescendant(of: sut.view))
    }
    
    func testHasSaveButton(){
        XCTAssertTrue(sut.saveButton.isDescendant(of: sut.view))
    }
    
    func testHasCancelButton(){
        XCTAssertTrue(sut.cancelButton.isDescendant(of: sut.view))
    }
    
    func testSaveUsesGeocoderToConvertCoordinateFromAddress(){
        let df = DateFormatter()
        df.dateFormat = "dd.MM.yy"
        let date = df.date(from: "01.10.20")
        
        sut.titleTextField.text = "Foo"
        sut.locationTextField.text = "Bar"
        sut.dateTextField.text = "01.10.20"
        sut.addressTextField.text = "Владимир"
        sut.descriptionTextField.text = "Baz"
        
        sut.taskManager = TaskManager()
        let mockGeocoder = MockCLGeocoder()
        sut.geocoder = mockGeocoder
        sut.save()
        
     
        let coordinate = CLLocationCoordinate2D(latitude: 56.1384307, longitude: 40.399975)
        let location = Location(name: "Bar", coordinate: coordinate)
        let generatedTask = Task(title: "Foo", description: "Baz", date: date, location: location)
        
        placemark = MockCLPlacemark()
        placemark.mockCoordinate = coordinate
        mockGeocoder.completionHandler?([placemark], nil)
        
        let task = sut.taskManager.task(at: 0)
        
        XCTAssertEqual(task, generatedTask)
    }
    
    func testSaveButtonHasSaveMethod(){
        let saveButton = sut.saveButton
        
        guard let actions = saveButton?.actions(forTarget: sut, forControlEvent: .touchUpInside) else{
            XCTFail()
            return
        }
        
        XCTAssertTrue(actions.contains("save"))
    }
    
    func testGeocoderFetchesCorrectCoordinate(){
        let geocoderAnswer = expectation(description: "Geocoder answer")
        let addressString = "Владимир"
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(addressString) { (placemarks, error) in
            let placemark = placemarks?.first
            let location = placemark?.location
            
            guard
                let latitude = location?.coordinate.latitude,
                let longitude = location?.coordinate.longitude else{
                XCTFail()
                return
            }
            XCTAssertEqual(latitude, 56.1384307)
            XCTAssertEqual(longitude, 40.399975)
            geocoderAnswer.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
    
     func testSaveDismissesNewTaskViewController() {
            // given
            let mockNewTaskViewController = MockNewTaskViewController()
            mockNewTaskViewController.titleTextField = UITextField()
            mockNewTaskViewController.titleTextField.text = "Foo"
            mockNewTaskViewController.descriptionTextField = UITextField()
            mockNewTaskViewController.descriptionTextField.text = "Bar"
            mockNewTaskViewController.locationTextField = UITextField()
            mockNewTaskViewController.locationTextField.text = "Baz"
            mockNewTaskViewController.addressTextField = UITextField()
            mockNewTaskViewController.addressTextField.text = "Vladimir"
            mockNewTaskViewController.dateTextField = UITextField()
            mockNewTaskViewController.dateTextField.text = "01.01.19"
            
            // when
            mockNewTaskViewController.save()
            
            // then
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                XCTAssertTrue(mockNewTaskViewController.isDismissed)
            }
        }
    }

    extension NewTaskViewControllerTests {
        class MockCLGeocoder: CLGeocoder {
            
            var completionHandler: CLGeocodeCompletionHandler?
            
            override func geocodeAddressString(_ addressString: String, completionHandler: @escaping CLGeocodeCompletionHandler) {
                self.completionHandler = completionHandler
            }
        }
        
        class MockCLPlacemark: CLPlacemark {
            
            var mockCoordinate: CLLocationCoordinate2D!
            
            override var location: CLLocation? {
                return CLLocation(latitude: mockCoordinate.latitude, longitude: mockCoordinate.longitude)
            }
        }
    }

    extension NewTaskViewControllerTests {
        
        class MockNewTaskViewController: NewTaskViewController {
            var isDismissed = false
            
            override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
                isDismissed = true
            }
        }
    }
