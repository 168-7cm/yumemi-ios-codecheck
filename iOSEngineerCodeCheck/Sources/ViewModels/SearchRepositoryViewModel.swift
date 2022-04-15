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
    func searchRepository(keyword: String)
}

protocol SearchRepositoryViewModelOutputs {
    var repositories: Observable<[SectionModel]> { get }
    var isLoading: Observable<Bool> { get }
}

protocol SearchRepositoryViewModelType {
    var inputs: SearchRepositoryViewModelInputs { get }
    var outputs: SearchRepositoryViewModelOutputs { get }
}

final class SearchRepositoryViewModel {

    private let model: SearchRepositoryModelType
    private let repositoriesRelay = BehaviorRelay<[SectionModel]>(value: [])
    private let isLoadingRelay = BehaviorRelay<Bool>(value: false)
    private let disposeBag = DisposeBag()

    init(model: SearchRepositoryModelType) {
        self.model = model
    }
}

extension SearchRepositoryViewModel: SearchRepositoryViewModelType {
    var inputs: SearchRepositoryViewModelInputs { return self }
    var outputs: SearchRepositoryViewModelOutputs { return self }
}

extension SearchRepositoryViewModel: SearchRepositoryViewModelInputs {
    func searchRepository(keyword: String) {
        isLoadingRelay.accept(true)
        model.searchRepository(keyword: keyword)
            .subscribe(
                onSuccess: { [weak self] repositories in
                    self?.isLoadingRelay.accept(false)
                    let sectionItems: [SectionItem] = repositories.map { .main(repository: $0) }
                    let sectionModel: [SectionModel] = [.header(title: "", items: sectionItems)]
                    self?.repositoriesRelay.accept(sectionModel)
                },
                onFailure: { [weak self] _ in
                    self?.isLoadingRelay.accept(false)
                    // TODO: show error alert
                }).disposed(by: disposeBag)
    }
}

extension SearchRepositoryViewModel: SearchRepositoryViewModelOutputs {
    var repositories: Observable<[SectionModel]> { return repositoriesRelay.asObservable() }
    var isLoading: Observable<Bool> { return isLoadingRelay.asObservable() }
}
