//
//  WeatherAppUITests.swift
//  WeatherAppUITests
//
//  Created by Mohammed Hassanien on 04/05/2026.
//

import XCTest

final class WeatherAppUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        app.activate()
        app/*@START_MENU_TOKEN@*/.images["Vector 11"]/*[[".otherElements.images[\"Vector 11\"]",".images[\"Vector 11\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.firstMatch.tap()
        app.otherElements.element(boundBy: 8).tap()
        app/*@START_MENU_TOKEN@*/.staticTexts["Cairo"]/*[[".buttons.staticTexts[\"Cairo\"]",".staticTexts[\"Cairo\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.firstMatch.tap()
        app/*@START_MENU_TOKEN@*/.buttons["arrow.left"]/*[[".otherElements",".buttons[\"Left\"]",".buttons[\"arrow.left\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.firstMatch.tap()
        app/*@START_MENU_TOKEN@*/.staticTexts["forecastReportText"]/*[[".buttons[\"Forecast report\"].staticTexts",".buttons",".staticTexts[\"Forecast report\"]",".staticTexts[\"forecastReportText\"]"],[[[-1,3],[-1,2],[-1,1,1],[-1,0]],[[-1,3],[-1,2]]],[0]]@END_MENU_TOKEN@*/.firstMatch.tap()
        app/*@START_MENU_TOKEN@*/.buttons["Back"]/*[[".buttons",".containing(.staticText, identifier: \"Back\")",".containing(.image, identifier: \"chevron.left\")",".otherElements.buttons[\"Back\"]",".buttons[\"Back\"]"],[[[-1,4],[-1,3],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.firstMatch.tap()
        
                // Use XCTAssert and related functions to verify your tests produce the correct results.
        // XCUIAutomation Documentation
        // https://developer.apple.com/documentation/xcuiautomation
    }

  
    
}
