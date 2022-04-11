//
//  GitHubSearchViewModel.swift
//  iOSEngineerCodeCheck
//
//  Created by Kou Yamamoto on 2022/04/09.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import Foundation
import RxSwift
import RxRelay

protocol SearchRepositoryViewModelInputs {
    func searchRepository(GitHubAPI: GitHubAPI)
}

protocol SearchRepositoryViewModelOutputs {
    var repositories: Observable<[Repository]> { get }
}

protocol SearchRepositoryViewModelType {
    var inputs: SearchRepositoryViewModelInputs { get }
    var outputs: SearchRepositoryViewModelOutputs { get }
}

final class SearchRepositoryViewModel {

    private let model: SearchRepositoryModelType
    private let repositoriesRelay = BehaviorRelay<[Repository]>(value: [])
    private let disposeBag = DisposeBag()

    init(model: SearchRepositoryModelType) {
        self.model = model
    }
}

extension SearchRepositoryViewModel: SearchRepositoryViewModelType {
    var inputs: SearchRepositoryViewModelInputs { return self }
    var outputs: SearchRepositoryViewModelOutputs { return self }
}

// TODO: show error alert
extension SearchRepositoryViewModel: SearchRepositoryViewModelInputs {
    func searchRepository(GitHubAPI: GitHubAPI) {
        model.searchRepository(gitHubAPI: GitHubAPI)
            .subscribe(
                onSuccess: { [weak self] repositories in
                    self?.repositoriesRelay.accept(repositories)
                },
                onFailure: { _ in
                }).disposed(by: disposeBag)
    }
}

extension SearchRepositoryViewModel: SearchRepositoryViewModelOutputs {
    var repositories: Observable<[Repository]> { return repositoriesRelay.asObservable() }
}
