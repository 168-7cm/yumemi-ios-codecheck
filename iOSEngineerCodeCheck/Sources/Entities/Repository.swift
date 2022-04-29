//
//  Repository.swift
//  iOSEngineerCodeCheck
//
//  Created by Kou Yamamoto on 2022/04/09.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

struct Repository: Codable {
    let owner: Owner
    let fullName: String
    let language: String?
    let starsCount: Int
    let watchersCount: Int
    let forksCount: Int
    let openIssuesCount: Int
    let description: String?

    enum CodingKeys: String, CodingKey {
        case owner
        case fullName = "full_name"
        case language
        case starsCount = "stargazers_count"
        case watchersCount = "watchers_count"
        case forksCount = "forks_count"
        case openIssuesCount = "open_issues_count"
        case description
    }
}
