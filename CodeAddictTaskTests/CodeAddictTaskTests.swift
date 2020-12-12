//
//  CodeAddictTaskTests.swift
//  CodeAddictTaskTests
//
//  Created by Jakub Homik on 09/12/2020.
//

import XCTest
@testable import CodeAddictTask

class CodeAddictTaskTests: XCTestCase {

    var decoder: JSONDecoder!
    var deserialized: ListCommits!
    let response = """
                            [
                              {
                                "commit": {
                                  "author": {
                                    "name": "Monalisa Octocat",
                                    "email": "support@github.com"
                                  },
                                  "committer": {
                                    "name": "Monalisa Octocat",
                                    "email": "support@github.com"
                                  },
                                  "message": "Fix all the bugs"
                                }
                              }
                            ]
                            """.data(using: .utf8)!
    
    override func setUp() {
           super.setUp()
           decoder = JSONDecoder()
           deserialized = try! decoder.decode(ListCommits.self, from: response)
       }
}

