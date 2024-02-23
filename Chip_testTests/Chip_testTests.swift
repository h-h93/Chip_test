//
//  Chip_testTests.swift
//  Chip_testTests
//
//  Created by hanif hussain on 21/02/2024.
//

import XCTest
@testable import Chip_test

final class Chip_testTests: XCTestCase {
    

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFetchDogs() {
           let requests = Requests()
           let url = URL(string: "https://dog.ceo/api/breeds/list/all")!
           let expectation = XCTestExpectation(description: "Fetch dogs expectation")
           
           requests.fetchDogs(url) { (dogs) in
               // Check if the received Dogs object is not nil
               XCTAssertNotNil(dogs)
               expectation.fulfill()
           }
           
           wait(for: [expectation], timeout: 5.0)
       }

       func testFetchDataCombine() {
           let requests = Requests()
           let url = URL(string: "https://images.dog.ceo/breeds/sharpei/noel.jpg")!
           let expectation = XCTestExpectation(description: "Fetch data expectation")
           
           requests.fetchData(url, defaultValue: Data()) { (data) in
               // Check if the received data is not empty
               XCTAssertFalse(data.isEmpty)
               expectation.fulfill()
           }
           
           wait(for: [expectation], timeout: 5.0)
       }

       func testGetData() {
           let requests = Requests()
           let url = URL(string: "https://images.dog.ceo/breeds/labrador/n02099712_3773.jpg")!
           let expectation = XCTestExpectation(description: "Get data expectation")
           
           requests.getData(url: url) { (result) in
               switch result {
               case .success(let data):
                   // Check if the received data is not empty
                   XCTAssertFalse(data.isEmpty)
                   expectation.fulfill()
               case .failure(let error):
                   XCTFail("Failed to get data: \(error)")
               }
           }
           
           wait(for: [expectation], timeout: 5.0)
       }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
