//
//  RepositoryDetailState.swift
//  iOSEngineerCodeCheck
//
//  Created by Kou Yamamoto on 2022/04/29.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import ReSwift

struct RepositoryDetailReducer {

    static func reduce(action: Action, state: RepositoryDetailState?) -> RepositoryDetailState {

        var state = state ?? RepositoryDetailState()

        guard let action = action as? RepositoryDetailState.Action else { return state }

        switch action {
        case .beforeNavigation(let repository):
            state.repository = repository
        }
        return state
    }
}
