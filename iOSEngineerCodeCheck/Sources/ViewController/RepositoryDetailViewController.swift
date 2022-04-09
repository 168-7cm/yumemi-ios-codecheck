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
        getImage(repository: repository)
    }

    static func configure(repository: Repository) -> RepositoryDetailViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "ViewController2") as! RepositoryDetailViewController
        viewController.repository = repository
        return viewController
    }

    private func setupUI(repository: Repository) {
        repositoryLanguageLabel.text = "Written in \(repository.language)"
        repositoryStarCountLabel.text = "\(repository.starsCount) stars"
        repositoryWatcherCountLabel.text = "\(repository.watchersCount) watchers"
        repositoryForkedCountLabel.text = "\(repository.forksCount) forks"
        repositoryOpenIssueCountLabel.text = "\(repository.openIssuesCount) open issues"
    }
    
    private func getImage(repository: Repository) {

        repositoryTitleLabel.text = repository.fullName

        guard let url = URL(string: repository.owner.avatarURL) else { return }
        URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self?.repositoryImageView.image = image
                }
            }
        }.resume()
    }
}
