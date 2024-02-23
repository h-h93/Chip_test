//
//  Chip_testUITests.swift
//  Chip_testUITests
//
//  Created by hanif hussain on 21/02/2024.
//

import XCTest

final class Chip_testUITests: XCTestCase {
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        app = XCUIApplication()
        app.activate()
        continueAfterFailure = false
        app.launch()
    }

    override func tearDownWithError() throws {
        app = nil
        super.tearDown()
    }

    func testCollectionViewCellTap_NavigatesToDogImagesViewController() {
            // check if table view layout is correct
            let firstCell = app.collectionViews.cells.element(boundBy: 0)
            XCTAssertTrue(firstCell.exists)
        }
    
    func testImagesDisplayed() {
        
        let app = XCUIApplication()
        let collectionViewsQuery = app.collectionViews
        let cell = collectionViewsQuery.children(matching: .cell).element(boundBy: 0)
        cell.tap()
        
        let cell2 = collectionViewsQuery.scrollViews.children(matching: .cell).element
        cell2.swipeLeft()
        cell2.swipeLeft()
        
        let dogApiButton = app.navigationBars["Dog Pics"].buttons["Dog API"]
        dogApiButton.tap()
        cell.children(matching: .textView).element.swipeUp()
        app.windows.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .collectionView).element.swipeUp()
        collectionViewsQuery.children(matching: .cell).element(boundBy: 2).tap()
        cell2.swipeLeft()
        cell2.swipeLeft()
        dogApiButton.tap()
                
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
