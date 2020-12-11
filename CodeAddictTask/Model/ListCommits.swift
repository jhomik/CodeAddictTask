//
//  ListCommits.swift
//  CodeAddictTask
//
//  Created by Jakub Homik on 11/12/2020.
//

import Foundation

// MARK: - ListCommit
struct ListCommits: Decodable {
    let sha: String
    let commit: [Commit]
}

// MARK: - Commit
struct Commit: Decodable {
    let author: Author
    let message: String
}

// MARK: - Author
struct Author: Decodable {
    let name, email: String
}
