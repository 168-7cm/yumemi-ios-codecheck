//
//  AppAction.swift
//  iOSEngineerCodeCheck
//
//  Created by Kou Yamamoto on 2022/04/29.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import ReSwift

struct AppReducer {

    static func reduce(action: Action, state: AppState?) -> AppState {

        var state = state ?? AppState()
        state.searchRepositoryState = SearchRepositoryReducer.reduce(action: action, state: state.searchRepositoryState)
        state.repositoryDetailState = RepositoryDetailReducer.reduce(action: action, state: state.repositoryDetailState)
        return state
    }
}

