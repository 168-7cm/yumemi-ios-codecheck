//
//  ViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/20.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

final class GitHubSearchViewController: UITableViewController {

    @IBOutlet private weak var searchBar: UISearchBar!

    var repositories: [[String: Any]] = []
    var task: URLSessionTask?
    var index: Int!

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    private func setup() {
        searchBar.text = "GitHubのリポジトリを検索できるよー"
        searchBar.delegate = self
    }

    private func transition() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "ViewController2") as! ViewController2
        viewController.vc1 = self
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension GitHubSearchViewController: UISearchBarDelegate  {

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
                if let object = try! JSONSerialization.jsonObject(with: data!) as? [String: Any] {
                    if let repositories = object["items"] as? [[String: Any]] {
                        self.repositories = repositories
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    }
                }
            }
            task?.resume()
        }
    }
}

extension GitHubSearchViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositories.count
    }

    // TODO: セルの再利用
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let repository = repositories[indexPath.row]
        cell.textLabel?.text = repository["full_name"] as? String ?? ""
        cell.detailTextLabel?.text = repository["language"] as? String ?? ""
        cell.tag = indexPath.row
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        index = indexPath.row
        transition()
    }
}
