//
//  SearchRepositoryActionCreator.swift
//  iOSEngineerCodeCheck
//
//  Created by Kou Yamamoto on 2022/04/29.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import RxSwift
import ReSwift

final class SearchRepositoryActionCreator {

    private let disposeBag = DisposeBag()

    func searchRepository(keyword: String) {
        appStore.dispatch(SearchRepositoryState.Action.requestStart)
        SearchRepositoryModel().searchRepository(keyword: keyword)
            .subscribe(
                onSuccess: { repositories in
                    appStore.dispatch(SearchRepositoryState.Action.requestEnd)
                    appStore.dispatch(SearchRepositoryState.Action.requestSuccess(repositories: repositories))
                },
                onFailure: { error in
                    appStore.dispatch(SearchRepositoryState.Action.requestEnd)
                    appStore.dispatch(SearchRepositoryState.Action.requestFailure(error: error))
                }).disposed(by: disposeBag)
    }
}
