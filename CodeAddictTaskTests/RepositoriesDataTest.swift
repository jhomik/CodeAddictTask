//
//  RepositoriesDataTest.swift
//  CodeAddictTaskTests
//
//  Created by Jakub Homik on 14/12/2020.
//

import XCTest
@testable import CodeAddictTask

class RepositoriesDataTest: XCTestCase {

    var networkManager: NetworkManager!
    var withWord: String!
    var page: Int!
    
    func testFetchRepositories() {
        let expect = expectation(description: "fetch repositories")
        networkManager.searchRepositories(withWord: withWord, page: page) { (result) in
            switch result {
            case .success(let repositories):
                XCTAssertNotNil(repositories)
            case .failure(let error):
                XCTAssertNil("Test fetch error: \(error.rawValue)")
            }
            expect.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
    }

    override func setUp() {
        super.setUp()
        networkManager = NetworkManager()
        withWord = "CodeAddictTask"
        page = 0
    }

    override func tearDown() {
        networkManager = nil
        withWord = nil
        page = nil
        super.tearDown()
    }
}
