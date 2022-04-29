//
//  SearchRepositoryState.swift
//  iOSEngineerCodeCheck
//
//  Created by Kou Yamamoto on 2022/04/29.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import ReSwift

struct SearchRepositoryState {
    var repositories = [Repository]()
    var isLoading = false
    var error: Error?

    enum Action: ReSwift.Action {
        case requestStart
        case requestEnd
        case requestSuccess(repositories: [Repository])
        case requestFailure(error: Error)
    }
}
