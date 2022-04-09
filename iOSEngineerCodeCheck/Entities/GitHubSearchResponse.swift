//
//  GitHubSearchResponse.swift
//  iOSEngineerCodeCheck
//
//  Created by Kou Yamamoto on 2022/04/09.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import Foundation

struct GitHubSearchResponse: Codable {
    let items: [Repository]
}
