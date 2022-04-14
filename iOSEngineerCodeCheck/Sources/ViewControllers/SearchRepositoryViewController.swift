//
//  ViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/20.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class SearchRepositoryViewController: UIViewController {

    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var activityIndicatorView: UIActivityIndicatorView!

    private var viewModel: SearchRepositoryViewModelType!
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        bindUI()
    }

    static func configure() -> SearchRepositoryViewController {
        let viewController = StoryboardScene.SearchRepository.searchRepository.instantiate()
        viewController.viewModel = SearchRepositoryViewModel(model: SearchRepositoryModel())
        return viewController
    }

    private func setup() {
        activityIndicatorView.hidesWhenStopped = true
        tableView.registerCustomCell(RepositoryCell.self)
        tableView.keyboardDismissMode = .onDrag
        searchBar.text = L10n.SearchBar.Initial.message
    }

    private func bindUI() {

        Observable.zip(
            tableView.rx.modelSelected(Repository.self),
            tableView.rx.itemSelected
        ).subscribe(onNext: { [weak self] repository, indexPath in
            self?.tableView.deselectRow(at: indexPath, animated: true)
            self?.transitionToRepositoryDetail(repository: repository)
        }).disposed(by: disposeBag)

        searchBar.rx.text.orEmpty
            .subscribe(onNext: { [weak self] keyword in
                self?.viewModel.inputs.searchRepository(keyword: keyword)
            }).disposed(by: disposeBag)

        searchBar.rx.searchButtonClicked
            .subscribe(onNext: { [weak self] _ in
                self?.searchBar.resignFirstResponder()
            }).disposed(by: disposeBag)

        viewModel.outputs.repositories
            .bind(to: tableView.rx.items(cellIdentifier: RepositoryCell.identifier, cellType: RepositoryCell.self)) { index, repository, cell in
                cell.configure(repository: repository)
            }.disposed(by: disposeBag)

        viewModel.outputs.isLoading
            .subscribe(onNext: { [weak self] isLoading in
                isLoading ? self?.activityIndicatorView.startAnimating() : self?.activityIndicatorView.stopAnimating()
            }).disposed(by: disposeBag)
    }

    private func transitionToRepositoryDetail(repository: Repository) {
        let viewController = RepositoryDetailViewController.configure(repository: repository)
        navigationController?.pushViewController(viewController, animated: true)
    }
}
