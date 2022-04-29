//
//  GitHubAPI.swift
//  iOSEngineerCodeCheck
//
//  Created by Kou Yamamoto on 2022/04/09.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import Alamofire

enum GitHubAPI {
    case searchRepository(keyword: String)
    case searchUser(userName: String)

    var baseUrl: URL {
        return URL(string: "https://api.github.com")!
    }

    var path: String {
        switch self {
        case .searchRepository:
            return "/search/repositories"
        case .searchUser:
            return "/search/users"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .searchRepository:
            return .get
        case .searchUser:
            return .get
        }
    }

    var parameters: Parameters {
        switch self {
        case .searchRepository(let keyword):
            return ["q": keyword]
        case .searchUser(let userName):
            return ["q": userName]
        }
    }
}
