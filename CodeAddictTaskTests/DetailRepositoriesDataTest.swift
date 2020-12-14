//
//  DetailRepositoriesDataTest.swift
//  CodeAddictTaskTests
//
//  Created by Jakub Homik on 14/12/2020.
//

import XCTest
@testable import CodeAddictTask

class DetailRepositoriesDataTest: XCTestCase {

    var decoder: JSONDecoder!
    var deserialized: DetailRepositories!
    let response = """
                           {
                             "name": "CodeAddictTask",
                             "owner": {
                               "login": "jhomik",
                               "avatar_url": "https://avatars3.githubusercontent.com/u/29075071?v=4"
                             },
                               "stargazers_count": 0,
                               "html_url": "https://github.com/jhomik/CodeAddictTask"
                           }
                           """.data(using: .utf8)!
    
    override func setUp() {
        super.setUp()
        decoder = JSONDecoder()
        deserialized = try! decoder.decode(DetailRepositories.self, from: response)
    }
    
    override func tearDown() {
        decoder = nil
        deserialized = nil
        super.tearDown()
    }
    
    func testNameRepo() {
        XCTAssert(deserialized.name == "CodeAddictTask")
    }
    
    func testAvatarUrlOwner() {
        XCTAssert(deserialized.owner.avatarURL == "https://avatars3.githubusercontent.com/u/29075071?v=4")
    }
    
    func testStarsNumbers() {
        XCTAssert(deserialized.stargazersCount == 0)
    }
    
    func testLoginOwner() {
        XCTAssert(deserialized.owner.login == "jhomik")
    }
    
    func testRepoUrl() {
        XCTAssert(deserialized.htmlUrl == "https://github.com/jhomik/CodeAddictTask")
    }
}
