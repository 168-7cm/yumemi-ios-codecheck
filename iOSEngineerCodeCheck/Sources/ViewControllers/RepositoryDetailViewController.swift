//
//  ViewController2.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/21.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit
import NSObject_Rx

final class RepositoryDetailViewController: UIViewController {
    
    @IBOutlet private weak var repositoryImageView: UIImageView!
    @IBOutlet private weak var repositoryTitleLabel: UILabel!
    @IBOutlet private weak var repositoryLanguageLabel: UILabel!
    @IBOutlet private weak var repositoryStarCountLabel: UILabel!
    @IBOutlet private weak var repositoryWatcherCountLabel: UILabel!
    @IBOutlet private weak var repositoryForkedCountLabel: UILabel!
    @IBOutlet private weak var repositoryOpenIssueCountLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }

    static func configure() -> RepositoryDetailViewController {
        let viewController = StoryboardScene.RepositoryDetail.repositoryDetail.instantiate()
        return viewController
    }

    private func bind() {
        rxStore.rxStateDriver.compactMap { $0.repositoryDetailState.repository }
            .asDriver()
            .drive(onNext: { [weak self] repository in
                self?.setupUI(repository: repository)
            }).disposed(by: rx.disposeBag)
    }

    private func setupUI(repository: Repository) {
        repositoryLanguageLabel.text = "Written in \(repository.language ?? "")"
        repositoryStarCountLabel.text = "\(repository.starsCount) stars"
        repositoryWatcherCountLabel.text = "\(repository.watchersCount) watchers"
        repositoryForkedCountLabel.text = "\(repository.forksCount) forks"
        repositoryOpenIssueCountLabel.text = "\(repository.openIssuesCount) open issues"
        repositoryTitleLabel.text = "\(repository.fullName) open issues"
        repositoryImageView.image = UIImage(url: repository.owner.avatarURL)
    }
}
