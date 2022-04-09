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

    private var viewModel: SearchRepositoryViewModelType!
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    static func configure() -> SearchRepositoryViewController {
        let viewController = StoryboardScene.SearchRepositoryViewController.searchRepository.instantiate()
        viewController.viewModel = SearchRepositoryViewModel(model: SearchRepositoryModel())
        return viewController
    }

    private func setup() {
        searchBar.text = "GitHubのリポジトリを検索できるよー"
        searchBar.delegate = self
        bind()
    }

    private func bind() {

        viewModel
            .outputs
            .repositories
            .bind(to: tableView.rx.items(cellIdentifier: "RepositoryCell")) { row, repository, cell in
                cell.textLabel?.text = repository.fullName
                cell.detailTextLabel?.text = repository.language
            }.disposed(by: disposeBag)
    }

    private func transitionToRepositoryDetailViewController(repository: Repository) {
        let viewController = RepositoryDetailViewController.configure(repository: repository)
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension SearchRepositoryViewController: UISearchBarDelegate  {

    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.text = ""
        return true
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let gitHubAPI = GitHubAPI.searchRepository(keyword: searchBar.text!)
        viewModel.inputs.searchRepository(GitHubAPI: gitHubAPI)
    }
}
