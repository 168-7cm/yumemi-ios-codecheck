//
//  ViewController2.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/21.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

final class RepositoryDetailViewController: UIViewController {
    
    @IBOutlet private weak var repositoryImageView: UIImageView!
    @IBOutlet private weak var repositoryTitleLabel: UILabel!
    @IBOutlet private weak var repositoryLanguageLabel: UILabel!
    @IBOutlet private weak var repositoryStarCountLabel: UILabel!
    @IBOutlet private weak var repositoryWatcherCountLabel: UILabel!
    @IBOutlet private weak var repositoryForkedCountLabel: UILabel!
    @IBOutlet private weak var repositoryOpenIssueCountLabel: UILabel!
    
    private var repository: Repository!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI(repository: repository)
    }

    static func configure(repository: Repository) -> RepositoryDetailViewController {
        let viewController = StoryboardScene.RepositoryDetail.repositoryDetail.instantiate()
        viewController.repository = repository
        return viewController
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
