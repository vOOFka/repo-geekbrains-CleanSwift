//
//  shopVSUITests.swift
//  shopVSUITests
//
//  Created by Home on 12.02.2022.
//

import XCTest

class shopVSUITests: XCTestCase {
    var app: XCUIApplication!
    var scrollViewsQuery: XCUIElementQuery!

    override func setUpWithError() throws {
        continueAfterFailure = false
        
        app = XCUIApplication()
        app.launch()
        scrollViewsQuery = app.scrollViews
    }

    override func tearDownWithError() throws {
        app = nil
        scrollViewsQuery = nil
    }

    private func deleteTextIn(_ textField: XCUIElement) {
        while !(textField.value as! String).isEmpty {
            let deleteKey = XCUIApplication().keys["delete"]
            deleteKey.tap()
        }
    }
    
    private func enterAuthorizationData(login: String, password: String) {
        let loginTextField = scrollViewsQuery.textFields["loginTextField"].firstMatch
        let passwordTextField = scrollViewsQuery.secureTextFields["passwordTextField"].firstMatch
        let enterButton = scrollViewsQuery.buttons["enterButton"].firstMatch
        
        loginTextField.tap()
        deleteTextIn(loginTextField)
        loginTextField.typeText(login)
        
        passwordTextField.tap()
        deleteTextIn(passwordTextField)
        passwordTextField.typeText(password)
        
        enterButton.tap()
    }
    
    func testLoginSuccess() throws {
        enterAuthorizationData(login: "Test", password: "qwerty123")
        let catalogNavigationLabel = app.navigationBars["Catalog"].staticTexts["Catalog"].label
        XCTAssertEqual(catalogNavigationLabel, "Catalog")
    }
    
    func testLoginFail() throws {
        enterAuthorizationData(login: "admin", password: "admin")
        app.alerts["Error"].scrollViews.otherElements.buttons["Close"].tap()
    }
}
