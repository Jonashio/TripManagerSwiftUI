//
//  TripManagerSwiftUIUITests.swift
//  TripManagerSwiftUIUITests
//
//  Created by Jonashio on 24/7/22.
//

import XCTest
@testable import TripManagerSwiftUI

class ContactViewUITest: XCTestCase {
    
    let dataForm = (name: "Jona", surname: "lh", mail: "adsf@adsf.com", comments: "asfasdfasf")

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {}

    func testOpenAndCloseContactView() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        // TripsListView is showing
        XCTAssert(app.staticTexts["Trips list"].exists)
        // Go to ContactView
        app.buttons["contact"].tap()
        // Check if the button Cancel(tobe in ContactView) exist
        XCTAssert(app.buttons["Cancel"].waitForExistence(timeout: 2))
        // Close form
        app.buttons["Cancel"].tap()
        // Check if the form is really close
        XCTAssertFalse(app.buttons["Cancel"].waitForExistence(timeout: 0.5))
    }
    
    func testSetNewReportInContactView() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        // TripsListView is showing
        XCTAssert(app.staticTexts["Trips list"].exists)
        // Go to ContactView
        app.buttons["contact"].tap()
        // Check if the button Cancel(tobe in ContactView) exist
        XCTAssert(app.buttons["Cancel"].waitForExistence(timeout: 2))
        
        // type form
        let username = app.textFields["Name"]
        username.tap()
        username.typeText(dataForm.name)
        
        let surname = app.textFields["Surname"]
        surname.tap()
        surname.typeText(dataForm.surname)
        
        let mail = app.textFields["Mail"]
        mail.tap()
        mail.typeText(dataForm.mail)
        
        let comments = app.textFields["Comments"]
        comments.tap()
        comments.typeText(dataForm.comments)
        
        // Send form
        app.buttons["Send"].tap()
        
        // Check if the form is really close dont have any problem
        XCTAssertFalse(app.buttons["Send"].waitForExistence(timeout: 1.5))
    }
}
