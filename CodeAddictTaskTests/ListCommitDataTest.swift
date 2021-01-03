//
//  ListCommitDataTest.swift
//  CodeAddictTaskTests
//
//  Created by Jakub Homik on 14/12/2020.
//

import XCTest
@testable import CodeAddictTask

class ListCommitDataTest: XCTestCase {
    
    var networkManager: NetworkManager!
    var forOwner: String!
    var repoName: String!
    
    func testFetchRepositories() {
        let expect = expectation(description: "fetch commits repositories")
        networkManager.getListCommits(forOwner: forOwner, repoName: repoName) { (result) in
            switch result {
            case .success(let commits):
                XCTAssertNotNil(commits)
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
