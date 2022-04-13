//
//  SearchRepositoryCell.swift
//  iOSEngineerCodeCheck
//
//  Created by Kou Yamamoto on 2022/04/11.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import UIKit

final class RepositoryCell: UITableViewCell {

    @IBOutlet private weak var repositoryNameLabel: UILabel!
    @IBOutlet private weak var repositoryDescriptionLabel: UILabel!
    @IBOutlet private weak var repositoryStarsCountLabel: UILabel!
    @IBOutlet private weak var repositoryLanguageLabel: UILabel!
    @IBOutlet private weak var repositoryLanguageColorView: UIView!

    func configure(repository: Repository) {
        repositoryNameLabel.text = repository.fullName
        // TODO: 説明文を取得するようにする
        repositoryDescriptionLabel.text = "あああああああああああああ"
        repositoryStarsCountLabel.text = "\(repository.starsCount)"
        repositoryLanguageLabel.text = repository.language
        repositoryLanguageColorView.backgroundColor = ProgramingLanguage(rawValue: repository.language).langColor
    }
}
