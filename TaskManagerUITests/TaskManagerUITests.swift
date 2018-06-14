//
//  TaskManagerUITests.swift
//  TaskManagerUITests
//
//  Created by Денис Ефимов on 06.06.2018.
//  Copyright © 2018 Denis Efimov. All rights reserved.
//

import XCTest

class TaskManagerUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.

        app = XCUIApplication()
        app.launch()
        
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testMainNavigationBarPlusButtonAndDetailViewFields() {
        
        // Getting main view controllers navigation bar
        let mainView = app.navigationBars["TaskManager.TMMainView"]
        let plusButtonItem = mainView.buttons["Add new"]
        
        // Check that our button exist
        XCTAssert(mainView.exists)
        XCTAssert(plusButtonItem.exists)
        
        // Going to Detail View (create new Task)
        plusButtonItem.tap()
        
        let detailView = app.navigationBars["TaskManager.TMTaskDetailView"]
        
        // Check that Detail View exist
        XCTAssert(detailView.exists)
        
        let tablesQuery = app.tables
        
        // Title text field
        let nameField = tablesQuery.textFields["Name"]
        
        // Category row
        let categoryField = tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Tap to select a category..."]/*[[".cells.staticTexts[\"Tap to select a category...\"]",".staticTexts[\"Tap to select a category...\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        
        // Date text field
        let dateField = tablesQuery/*@START_MENU_TOKEN@*/.textFields["Tap to select date..."]/*[[".cells.textFields[\"Tap to select date...\"]",".textFields[\"Tap to select date...\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        
        // Check that fields exists
        XCTAssert(nameField.exists)
        XCTAssert(categoryField.exists)
        XCTAssert(dateField.exists)
        
        // Check that picker is appeare when date tapped
        dateField.tap()
        XCTAssert(app.datePickers.count == 1, "Date change work incorret: cont of Date picker: \(app.datePickers.count)")

        // Check that category selection works
        categoryField.tap()
        let selectCategoryView = app.navigationBars["TaskManager.TMSelectCategoryTableView"]
        let selectCategoryViewBackButton = selectCategoryView.buttons["Back"]
        
        XCTAssert(selectCategoryView.exists)
        XCTAssert(selectCategoryViewBackButton.exists, "No back button in Select Category view")
        
        selectCategoryViewBackButton.tap()
        
        let deleteButton = detailView.buttons["Delete"]
        
        XCTAssert(deleteButton.exists, "No delete button in Detail view")
        
        deleteButton.tap()
        
    }

    func testMainNavigationBarSettingsButton() {
        
        // Getting main view controllers navigation bar
        let mainView = app.navigationBars["TaskManager.TMMainView"]
        
        // Getting navigation bar button items
        let settingsButtonItem = mainView.buttons["Settings"]
        
        // Check all our buttons exists
        XCTAssert(mainView.exists)
        XCTAssert(settingsButtonItem.exists)
        
        settingsButtonItem.tap()
        
        let settingsView = app.navigationBars["TaskManager.TMSettingsView"]
        
        let settingsViewBackButton = settingsView.buttons["Back"]
        
        // Check that Settings View exist
        XCTAssert(settingsView.exists)
        XCTAssert(settingsViewBackButton.exists, "No back button in Settings view")
        
        settingsViewBackButton.tap()
        
    }
}
