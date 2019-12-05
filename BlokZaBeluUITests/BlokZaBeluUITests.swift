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
        app.buttons["new game"].tap()
        
        app.navigationBars["BlokZaBelu.ScoreView"].buttons[localizedString(key: "add")].tap()
        app.buttons["camera"].firstMatch.tap()
        snapshot("02Detector")
        app.buttons[localizedString(key: "uitest.done")].tap()
        app.buttons[localizedString(key: "them")].tap()
        app.buttons["plus"].firstMatch.tap()
        app.cells.firstMatch.tap()
        snapshot("03AddScore")
        app.buttons[localizedString(key: "button.add").uppercased()].tap()
        snapshot("04Scores")
        app.navigationBars["BlokZaBelu.ScoreView"].buttons[localizedString(key: "uitest.back")].tap()
        app.buttons["history"].tap()
        snapshot("05History")
        app.navigationBars["BlokZaBelu.HistoryView"].buttons[localizedString(key: "uitest.back")].tap()
        app.buttons["settings0"].tap()
        snapshot("06Settings")
    }
    
}
