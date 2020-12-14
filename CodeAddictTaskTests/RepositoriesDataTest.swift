//
//  RepositoriesDataTest.swift
//  CodeAddictTaskTests
//
//  Created by Jakub Homik on 14/12/2020.
//

import XCTest
@testable import CodeAddictTask

class RepositoriesDataTest: XCTestCase {

    var decoder: JSONDecoder!
    var deserialized: RepositoriesResponse!
    let response = """
                           {
                             "items": [
                               {
                                 "name": "pillReminder",
                                 "owner": {
                                   "login": "jhomik",
                                   "avatar_url": "https://avatars3.githubusercontent.com/u/29075071?v=4"
                                 },
                                 "stargazers_count": 2
                               }
                             ]
                           }
                           """.data(using: .utf8)!
    
    override func setUp() {
        super.setUp()
        decoder = JSONDecoder()
        deserialized = try! decoder.decode(RepositoriesResponse.self, from: response)
    }
    
    override func tearDown() {
        decoder = nil
        deserialized = nil
        super.tearDown()
    }
    
    func testNameRepo() {
        XCTAssert(deserialized.items[0].name == "pillReminder")
    }
    
    func testAvatarUrlOwner() {
        XCTAssert(deserialized.items[0].owner.avatarURL == "https://avatars3.githubusercontent.com/u/29075071?v=4")
    }
    
    func testStarsNumbers() {
        XCTAssert(deserialized.items[0].stargazersCount == 2)
    }
    
    func testLoginOwner() {
        XCTAssert(deserialized.items[0].owner.login == "jhomik")
    }
}
