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
    
    private var repository: [String: Any] = [:]

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI(repository: repository)
        getImage(repository: repository)
    }

    func confiture(repository: [String: Any]) {
        self.repository = repository
    }

    private func setupUI(repository: [String: Any]) {
        repositoryLanguageLabel.text = "Written in \(repository["language"] as? String ?? "")"
        repositoryStarCountLabel.text = "\(repository["stargazers_count"] as? Int ?? 0) stars"
        repositoryWatcherCountLabel.text = "\(repository["wachers_count"] as? Int ?? 0) watchers"
        repositoryForkedCountLabel.text = "\(repository["forks_count"] as? Int ?? 0) forks"
        repositoryOpenIssueCountLabel.text = "\(repository["open_issues_count"] as? Int ?? 0) open issues"
    }
    
    private func getImage(repository: [String: Any]) {

        repositoryTitleLabel.text = repository["full_name"] as? String
        
        if let owner = repository["owner"] as? [String: Any],
           let imageURL = owner["avatar_url"] as? String {
            URLSession.shared.dataTask(with: URL(string: imageURL)!) { (data, res, err) in
                let image = UIImage(data: data!)!
                DispatchQueue.main.async {
                    self.repositoryImageView.image = image
                }
            }.resume()
        }
    }
}
