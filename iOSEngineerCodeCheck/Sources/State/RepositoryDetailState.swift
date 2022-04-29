//
//  RepositoryDetailState.swift
//  iOSEngineerCodeCheck
//
//  Created by Kou Yamamoto on 2022/04/29.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import ReSwift

struct RepositoryDetailState {
    var repository: Repository?

    enum Action: ReSwift.Action {
        case beforeNavigation(repository: Repository)
    }
}
