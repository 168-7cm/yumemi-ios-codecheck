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
        bindUI()
    }

    static func configure() -> SearchRepositoryViewController {
        let viewController = StoryboardScene.SearchRepository.searchRepository.instantiate()
        viewController.viewModel = SearchRepositoryViewModel(model: SearchRepositoryModel())
        return viewController
    }

    private func setup() {
        tableView.registerCustomCell(RepositoryCell.self)
        searchBar.text = L10n.SearchBar.Initial.message
        searchBar.delegate = self
    }

    private func bindUI() {

        /* セルとのバインド */
        viewModel.outputs.repositories
            .bind(to: tableView.rx.items(cellIdentifier: RepositoryCell.identifier, cellType: RepositoryCell.self)) { index, repository, cell in
                cell.configure(repository: repository)
            }.disposed(by: disposeBag)

        /* セル選択時 */
        tableView.rx.modelSelected(Repository.self)
            .subscribe(onNext: { [weak self] repository in
                self?.transitionToRepositoryDetail(repository: repository)
            }).disposed(by: disposeBag)
    }

    private func transitionToRepositoryDetail(repository: Repository) {
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
