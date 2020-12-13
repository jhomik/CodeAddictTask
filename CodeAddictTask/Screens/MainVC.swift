//
//  MainVC.swift
//  CodeAddictTask
//
//  Created by Jakub Homik on 09/12/2020.
//

import UIKit

final class MainVC: UIViewController {
    
    private let networkManager = NetworkManager()
    private let tableView = UITableView()
    private(set) var activityIndicator = UIActivityIndicatorView()
    private(set) var containerView = UIView()
    private(set) var hasMoreList = true
    private(set) var page = 1
    private(set) var searchWord = String()
    private(set) var cachedRepositories: [String:[Repositories]] = [:]
    
    private(set) var filteredRepositories: [Repositories] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureMainVC()
        configureTableView()
        configureSearchController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigationBarMainVC()
    }
    
    private func configureNavigationBarMainVC() {
        title = Constants.mainTitle
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.view.backgroundColor = .systemBackground
        navigationController?.navigationBar.barStyle = .default
        navigationController?.navigationBar.tintColor = .none
    }
    
    private func configureMainVC() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func configureSearchController() {
        let searchController = UISearchController()
        searchController.searchBar.delegate = self
        searchController.searchBar.searchTextField.clearButtonMode = .never
        searchController.searchBar.placeholder = Constants.searchForRepo
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
    }
    
    private func searchForRepositories(withWord: String, page: Int) {
        showLoadingSpinner(with: containerView, spinner: activityIndicator)
        networkManager.searchRepositories(withWord: withWord, page: page, completion: { [weak self] (result) in
            guard let self = self else { return }
            self.dismissLoadingSpinner(with: self.containerView, spinner: self.activityIndicator)
            switch result {
            case .success(let repositories):
                if repositories.items.count == 0 { self.hasMoreList = false }
                DispatchQueue.main.async {
                    if self.filteredRepositories.isEmpty {
                        self.filteredRepositories = repositories.items
                        self.hasMoreList = true
                    } else {
                        self.filteredRepositories.append(contentsOf: repositories.items)
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
    
    private func configureTableView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(MainCustomCell.self, forCellReuseIdentifier: Constants.mainCellReuseId)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension MainVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = DetailVC()
        detailVC.repositoryTitle = filteredRepositories[indexPath.section]
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY > contentHeight - height {
            guard hasMoreList else { return }
            page += 1
            searchForRepositories(withWord: searchWord, page: page)
        }
    }
}

extension MainVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return filteredRepositories.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 66
        default:
            return 9
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = RepositoryHeaderView()
        switch section {
        case 0:
            return headerView
        default:
            return UIView()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.mainCellReuseId, for: indexPath) as? MainCustomCell else { return UITableViewCell() }
        cell.repositories = filteredRepositories[indexPath.section]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 92
    }
}

extension MainVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(reload), object: searchBar)
        perform(#selector(reload), with: searchBar, afterDelay: 0.2)
    }
    
    @objc func reload(_ searchBar: UISearchBar) {
        view.endEditing(true)
        guard let query = searchBar.text, query.trimmingCharacters(in: .whitespaces) != "" else { return filteredRepositories.removeAll()
        }
        searchWord = query
        print(query)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        filteredRepositories.removeAll()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        filteredRepositories.removeAll()
        if let previouslySearchedRepo = cachedRepositories[searchBar.text ?? ""] {
            filteredRepositories = previouslySearchedRepo
        } else {
            searchForRepositories(withWord: searchWord, page: page)
        }
    }
}


