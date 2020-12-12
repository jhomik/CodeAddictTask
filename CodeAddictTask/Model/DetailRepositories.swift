//
//  DetailRepositories.swift
//  CodeAddictTask
//
//  Created by Jakub Homik on 10/12/2020.
//

import Foundation

// MARK: - DetailRepositories

struct DetailRepositories: Decodable {
    let name: String
    let owner: DetailOwner
    let stargazersCount: Int
    let htmlUrl: String

    enum CodingKeys: String, CodingKey {
        case name, owner
        case stargazersCount = "stargazers_count"
        case htmlUrl = "html_url"
    }
}

// MARK: - Owner

struct DetailOwner: Decodable {
    let login: String
    let avatarURL: String

    enum CodingKeys: String, CodingKey {
        case login
        case avatarURL = "avatar_url"
    }
}

