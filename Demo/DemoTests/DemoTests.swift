//
//  DemoTests.swift
//  DemoTests
//
//  Created by Евгений Уланов on 09.10.2020.
//  Copyright © 2020 Евгений Уланов. All rights reserved.
//

import XCTest
@testable import Demo

class DemoTests: XCTestCase {

    var sut: ViewController!
    override func setUpWithError() throws {
        super.setUp()
        sut = ViewController()
    }

    override func tearDownWithError() throws {
        sut = nil
        super.tearDown()
    }
 
    func testLowestVolumeShouldBeZero(){
        sut.setVolume(value: -100)
        
        let volume = sut.volume
        XCTAssert(volume == 0, "Lowes value should be equal 0.")
    }
    
    func testHighestVolumeShouldBe100(){
        sut.setVolume(value: 200)
        
        let volume = sut.volume
        XCTAssert(volume == 100, "Highest value should be equal 100.")
    }

    func testCharsInStringsAreTheSame(){
        //given
        let string1 = "qwerty"
        let string2 = "ytrewq"
        //when
        let bool = sut.charactersCompare(stringOne: string1, stringTwo: string2)
        //then
        XCTAssert(bool, "Characters should be the same in two strings.")
    }
    
    func testCharsInStringsAreDifferent(){
        //given
        let string1 = "qwerty"
        let string2 = "ytrewq12"
        //when
        let bool = sut.charactersCompare(stringOne: string1, stringTwo: string2)
        //then
        XCTAssert(!bool, "Characters should be different in two strings.")
    }
    
}
