//
//  HomePageCollectionViewTest.swift
//  Chip_testTests
//
//  Created by hanif hussain on 23/02/2024.
//

import XCTest
@testable import Chip_test

final class HomePageCollectionViewTest: XCTestCase {
    var sut: HomePageCollectionView!
    
    override func setUpWithError() throws {
        super.setUp()
        sut = HomePageCollectionView()
    }

    override func tearDownWithError() throws {
        sut = nil
        super.tearDown()
    }

    func testInit_WhenInitialized_CollectionViewIsNotNil() {
            XCTAssertNotNil(sut.collectionView)
        }

    func testDataSource_WhenInitialized_DogIsNotNil() {
            let expectation = XCTestExpectation(description: "Fetch dogs expectation")
            sut.dataProvider.fetchDogs { dog in
                XCTAssertNotNil(dog)
                expectation.fulfill()
            }
            wait(for: [expectation], timeout: 5.0)
        }

        func testCellForRow_WhenConfigured_CellDisplaysCorrectInfo() {
            let dog = DogsModel(breed: "sharpei", imageURL: URL(string: "https://images.dog.ceo/breeds/sharpei/noel.jpg")!, image: UIImage(systemName: "dog"))
            sut.dogs = [dog]
            let indexPath = IndexPath(item: 0, section: 0)
            let cell = sut.collectionView(sut.collectionView, cellForItemAt: indexPath) as! CustomHomeCollectionViewCell
            XCTAssertEqual(cell.textView.text, dog.breed)
            XCTAssertEqual(cell.imageView.image, dog.image)
        }

}
