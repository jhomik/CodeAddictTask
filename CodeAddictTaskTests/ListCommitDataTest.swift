//
//  ListCommitDataTest.swift
//  CodeAddictTaskTests
//
//  Created by Jakub Homik on 14/12/2020.
//

import XCTest
@testable import CodeAddictTask

class ListCommitDataTest: XCTestCase {

    var decoder: JSONDecoder!
    var deserialized: ListCommits!
    let response = """
                           [
                             {
                               "commit": {
                                 "author": {
                                   "name": "Jakub",
                                   "email": "jh.homik@gmail.com"
                                 },
                                 "message": "refactoring"
                               }
                             }
                           ]
                           """.data(using: .utf8)!
    
    override func setUp() {
        super.setUp()
        decoder = JSONDecoder()
        deserialized = try! decoder.decode(ListCommits.self, from: response)
    }
    
    override func tearDown() {
        decoder = nil
        deserialized = nil
        super.tearDown()
    }
    
    func testCommitAuthorName() {
        XCTAssert(deserialized[0].commit.author.name == "Jakub")
    }
    
    func testAuthorEmail() {
        XCTAssert(deserialized[0].commit.author.email == "jh.homik@gmail.com")
    }
    
    func testCommitMessage() {
        XCTAssert(deserialized[0].commit.message == "refactoring")
    }
}
