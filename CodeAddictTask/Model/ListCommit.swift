//
//  ListCommit.swift
//  CodeAddictTask
//
//  Created by Jakub Homik on 11/12/2020.
//

import Foundation

struct ListCommit: Codable {
    let commit: Commit
}

struct Commit: Codable {
    let author: Author
    let message: String
}

struct Author: Codable {
    let name, email: String
}

typealias ListCommits = [ListCommit]
