//
//  TaskTests.swift
//  ToDoApp(UnitTests)Tests
//
//  Created by Евгений Уланов on 09.10.2020.
//  Copyright © 2020 Евгений Уланов. All rights reserved.
//

import XCTest
@testable import ToDoApp_UnitTests_

class TaskTests:XCTestCase{
    
    func testInitTaskWithTitle(){
        let task = Task(title: "Foo")
        XCTAssertNotNil(task)
    }
    
    func testInitTaskWithTitleAndDesctiption(){
        let task = Task(title: "Foo", description: "Bar")
        XCTAssertNotNil(task)
    }
    
    func testWhenGivenTitleSetsTitle(){
        let task = Task(title: "Foo")
        XCTAssertEqual(task.title, "Foo")
    }
    
    func testWhenGivenDescriptionSetsDescription(){
        let task = Task(title: "Foo", description: "Bar")
        XCTAssertEqual(task.description, "Bar")
    }
    
    func testTaskInitsWithDate(){
        let task = Task(title: "Foo")
        XCTAssertNotNil(task.date)
    }
    
    func testWhenGivenLocationSetsLocation(){
        let location = Location(name:"Foo")
        
        let task = Task(title: "Bar",
                        description: "Baz",
                        location: location)
        
        XCTAssertEqual(location, task.location)
    }
    
    func testCanBeCreatedFromPlistDictionary(){
        let location = Location(name: "Baz")
        let date = Date(timeIntervalSince1970: 10)
        let task = Task(title: "Foo", description: "Bar", date: date, location: location)
        let locationDictionary: [String : Any] = ["name" : "Baz"]
        let dictionary: [String : Any] = ["title" : "Foo",
                                          "description": "Bar",
                                          "date" : date,
                                          "location" : locationDictionary]
        let createdTask = Task(dict: dictionary)
        XCTAssertEqual(task, createdTask)
    }
    
    func testCanBeSerializedIntoDictionary(){
        let location = Location(name: "Baz")
        let date = Date(timeIntervalSince1970: 10)
        let task = Task(title: "Foo", description: "Bar", date: date, location: location)
        
        let generatedTask = Task(dict: task.dict)
        
        XCTAssertEqual(task, generatedTask)
    }
}
