//
//  ListCommit.swift
//  CodeAddictTask
//
//  Created by Jakub Homik on 11/12/2020.
//

import Foundation

// MARK: - ListCommit

struct ListCommit: Codable {
    let commit: Commit
}

// MARK: - Commit

struct Commit: Codable {
    let author: Author
    let message: String
}

// MARK: - Author

struct Author: Codable {
    let name, email: String
}

typealias ListCommits = [ListCommit]
