//
//  BlokZaBeluUITests.swift
//  BlokZaBeluUITests
//
//  Created by Dominik Cubelic on 17/08/2019.
//  Copyright © 2019 Dominik Cubelic. All rights reserved.
//

import XCTest

//swiftlint:disable all

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

    func localizedString(key: String, tableName: String? = nil) -> String {
        //swiftlint:disable force_unwrapping
        let localizationBundle = Bundle(path: Bundle(for: BlokZaBeluUITests.self).path(forResource: deviceLanguage, ofType: "lproj")!)!
        return NSLocalizedString(key, tableName: tableName, bundle: localizationBundle, value: "", comment: "")
    }
    
    func testScreenshots() {
        
        let app = XCUIApplication()
        snapshot("01MainMenu")
        app.buttons[localizedString(key: "3sS-l5-5qw.normalTitle", tableName: "Main")].tap()
        
        let addButton = app.navigationBars["BlokZaBelu.ScoreView"].buttons[localizedString(key: "add")]
        addButton.tap()
        
        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element(boundBy: 1).children(matching: .other).element(boundBy: 1).children(matching: .other).element(boundBy: 2).children(matching: .other).element.children(matching: .button).matching(identifier: "camera").element(boundBy: 1).tap()
        snapshot("02Detector")
        app.buttons[localizedString(key: "2PL-a6-W6C.normalTitle", tableName: "Main")].tap()
        let app2 = app
        app2.children(matching: .window).element(boundBy: 0).children(matching: .other).element(boundBy: 1).children(matching: .other).element(boundBy: 1).children(matching: .other).element(boundBy: 3).tables/*@START_MENU_TOKEN@*/.buttons["+"]/*[[".cells.buttons[\"+\"]",".buttons[\"+\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app2.tables/*@START_MENU_TOKEN@*/.staticTexts["20"]/*[[".cells.staticTexts[\"20\"]",".staticTexts[\"20\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        snapshot("03AddScore")
        app.buttons[localizedString(key: "button.add").uppercased()].tap()
        snapshot("04Scores")
        
    }

}
