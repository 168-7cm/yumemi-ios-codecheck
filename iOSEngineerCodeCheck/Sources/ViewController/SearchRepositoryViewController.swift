//
//  ViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/20.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

final class SearchRepositoryViewController: UITableViewController {

    @IBOutlet private weak var searchBar: UISearchBar!

    var repositories: [Repository] = []
    var task: URLSessionTask?

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    private func setup() {
        searchBar.text = "GitHubのリポジトリを検索できるよー"
        searchBar.delegate = self
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

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        task?.cancel()
    }

    // TODO: データ通信処理はModel層に移行
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

        let searchWord = searchBar.text!

        if searchWord.count != 0 {
            let url = "https://api.github.com/search/repositories?q=\(searchWord)"
            task = URLSession.shared.dataTask(with: URL(string: url)!) { (data, response, error) in
                guard let response = try? JSONDecoder().decode(GitHubSearchResponse.self, from: data!) else { return }
                self.repositories = response.items
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
            task?.resume()
        }
    }
}

extension SearchRepositoryViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositories.count
    }

    // TODO: セルの再利用
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let repository = repositories[indexPath.row]
        cell.textLabel?.text = repository.fullName
        cell.detailTextLabel?.text = repository.language
        cell.tag = indexPath.row
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let repository = repositories[indexPath.row]
        transitionToRepositoryDetailViewController(repository: repository)
    }
}
