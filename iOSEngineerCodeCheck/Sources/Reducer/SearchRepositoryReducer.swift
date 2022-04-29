//
//  SearchRepositoryAction.swift
//  iOSEngineerCodeCheck
//
//  Created by Kou Yamamoto on 2022/04/29.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import ReSwift

struct SearchRepositoryReducer {

    static func reduce(action: Action, state: SearchRepositoryState?) -> SearchRepositoryState {

        var state = state ?? SearchRepositoryState()

        guard let action = action as? SearchRepositoryState.Action else { return state }

        switch action {
        case .requestStart:
            state.isLoading = true
        case .requestEnd:
            state.isLoading = false
        case .requestSuccess(let repositories):
            state.repositories = repositories
        case .requestFailure(let error):
            state.error = error
        }
        return state
    }
}
