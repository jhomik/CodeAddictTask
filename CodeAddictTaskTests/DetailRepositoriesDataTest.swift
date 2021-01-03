//
//  DetailRepositoriesDataTest.swift
//  CodeAddictTaskTests
//
//  Created by Jakub Homik on 14/12/2020.
//

import XCTest
@testable import CodeAddictTask

class DetailRepositoriesDataTest: XCTestCase {

    var networkManager: NetworkManager!
    var forOwner: String!
    var repoName: String!

    func testDetailRepositories() {
        let expect = expectation(description: "fetch detail repositories")
        networkManager.getRepositories(forOwner: forOwner, repoName: repoName) { (result) in
            switch result {
            case .success(let detailRepos):
                XCTAssertNotNil(detailRepos)
            case .failure(let error):
                XCTAssertNil("Test error: \(error.rawValue)")
            }
            expect.fulfill()
        }
        waitForExpectations(timeout: 2, handler: nil)
    }

    override func setUp() {
        super.setUp()
        networkManager = NetworkManager()
        forOwner = "jhomik"
        repoName = "CodeAddictTask"
    }

    override func tearDown() {
        networkManager = nil
        forOwner = nil
        repoName = nil
        super.tearDown()
    }
}
