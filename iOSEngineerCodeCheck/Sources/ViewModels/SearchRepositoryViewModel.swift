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
import RxCocoa

protocol SearchRepositoryViewModelInputs {
    func searchRepository(keyword: String)
}

protocol SearchRepositoryViewModelOutputs {
    var repositoriesDriver: Driver<[Repository]> { get }
    var isLoadingDriver: Driver<Bool> { get }
    var errorDriver: Driver<Error> { get }
}

protocol SearchRepositoryViewModelType {
    var inputs: SearchRepositoryViewModelInputs { get }
    var outputs: SearchRepositoryViewModelOutputs { get }
}

final class SearchRepositoryViewModel {

    private let model: SearchRepositoryModelType
    private let repositoriesRelay = BehaviorRelay<[Repository]>(value: [])
    private let isLoadingRelay = BehaviorRelay<Bool>(value: false)
    private let errorRelay = PublishRelay<Error>()
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
                    self?.repositoriesRelay.accept(repositories)
                },
                onFailure: { [weak self] error in
                    self?.isLoadingRelay.accept(false)
                    self?.errorRelay.accept(error)
                }).disposed(by: disposeBag)
    }
}

extension SearchRepositoryViewModel: SearchRepositoryViewModelOutputs {
    var repositoriesDriver: Driver<[Repository]> { return repositoriesRelay.asDriver() }
    var isLoadingDriver: Driver<Bool> { return isLoadingRelay.asDriver() }
    var errorDriver: Driver<Error> { return errorRelay.asDriver(onErrorDriveWith: .never()) }
}
