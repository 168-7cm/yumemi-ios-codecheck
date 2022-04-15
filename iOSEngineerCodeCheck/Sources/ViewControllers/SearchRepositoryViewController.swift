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
import RxDataSources

final class SearchRepositoryViewController: UIViewController {

    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var activityIndicatorView: UIActivityIndicatorView!

    private var viewModel: SearchRepositoryViewModelType!
    private let disposeBag = DisposeBag()

    private lazy var dataSource = RxCollectionViewSectionedReloadDataSource<SectionModel>(
        configureCell: { [weak self] dataSource, collectionView, indexPath, repository in
            switch dataSource[indexPath] {
            case let .main(repository: repository):
                let cell = collectionView.dequeueReusableCustomCell(with: RepositoryCell.self, indexPath: indexPath)
                cell.configure(repository: repository)
                return cell
            }
        })

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
        collectionView.collectionViewLayout = createCollectionViewLayout()
        collectionView.registerCustomCell(RepositoryCell.self)
        collectionView.keyboardDismissMode = .onDrag
        searchBar.text = L10n.SearchBar.Initial.message
    }

    private func bindUI() {

        Observable.zip(
            collectionView.rx.modelSelected(Repository.self),
            collectionView.rx.itemSelected
        ).subscribe(onNext: { [weak self] repository, indexPath in
            self?.transitionToRepositoryDetail(repository: repository)
        }).disposed(by: disposeBag)

        searchBar.rx.text.orEmpty.distinctUntilChanged()
            .subscribe(onNext: { [weak self] keyword in
                self?.viewModel.inputs.searchRepository(keyword: keyword)
            }).disposed(by: disposeBag)

        searchBar.rx.searchButtonClicked
            .subscribe(onNext: { [weak self] _ in
                self?.searchBar.resignFirstResponder()
            }).disposed(by: disposeBag)

        viewModel.outputs.isLoading
            .subscribe(onNext: { [weak self] isLoading in
                isLoading ? self?.activityIndicatorView.startAnimating() : self?.activityIndicatorView.stopAnimating()
            }).disposed(by: disposeBag)

        viewModel.outputs.repositories.bind(to: collectionView.rx.items(dataSource: dataSource)).disposed(by: disposeBag)
    }

    private func transitionToRepositoryDetail(repository: Repository) {
        let viewController = RepositoryDetailViewController.configure(repository: repository)
        navigationController?.pushViewController(viewController, animated: true)
    }
}

// セルレイアウトの処理
extension SearchRepositoryViewController {

    // CompositionalLayoutを作成する処理
    private func createCollectionViewLayout() -> UICollectionViewCompositionalLayout {

        let deviceWidth = UIScreen.main.bounds.width

        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in

            // 1. Itemのサイズ設定
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(100))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)

            // 2. Groupのサイズ設定
            let itemGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(100))
            let itemGroup = NSCollectionLayoutGroup.horizontal(layoutSize: itemGroupSize, subitem: item, count: 1)

            // 3. Sectionのサイズ設定
            let section = NSCollectionLayoutSection(group: itemGroup)
            section.interGroupSpacing = deviceWidth/100
            let sectionFooterSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.06))
            let sectionFooter = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: sectionFooterSize, elementKind: UICollectionView.elementKindSectionFooter, alignment: .bottom)
            section.boundarySupplementaryItems = [sectionFooter]
            return section
        }
        return layout
    }
}
