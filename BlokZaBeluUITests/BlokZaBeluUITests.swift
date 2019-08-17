//
//  BlokZaBeluUITests.swift
//  BlokZaBeluUITests
//
//  Created by Dominik Cubelic on 17/08/2019.
//  Copyright © 2019 Dominik Cubelic. All rights reserved.
//

import XCTest

class BlokZaBeluUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
        
        let app = XCUIApplication()
        setupSnapshot(app)
        app.launch()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        
        let app = XCUIApplication()
        
        snapshot("01MainMenu")
        
        app.buttons["CONTINUE"].tap()
        app.navigationBars["BlokZaBelu.ScoreView"].buttons["Add"].tap()
        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element(boundBy: 1).children(matching: .other).element(boundBy: 1).children(matching: .other).element(boundBy: 2).children(matching: .other).element.children(matching: .button).matching(identifier: "camera").element(boundBy: 0).tap()
        app.buttons["hearts"].tap()
        app.
        snapshot("02Detector")
        
        app.buttons["Done"].tap()
        snapshot("03AddScore")
        
        app.buttons["ADD"].tap()
        snapshot("04Scores")
        
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

}
