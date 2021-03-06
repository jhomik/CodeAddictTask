//
//  Repositories.swift
//  CodeAddictTask
//
//  Created by Jakub Homik on 10/12/2020.
//

import Foundation

struct RepositoriesResponse: Decodable {
    var items: [Repositories]
}

struct Repositories: Decodable {
    let name: String 
    let owner: Owner
    let stargazersCount: Int

    enum CodingKeys: String, CodingKey {
        case name, owner
        case stargazersCount = "stargazers_count"
    }
}

struct Owner: Decodable {
    let avatarURL: String?
    let login: String

    enum CodingKeys: String, CodingKey {
        case login
        case avatarURL = "avatar_url"
    }
}
