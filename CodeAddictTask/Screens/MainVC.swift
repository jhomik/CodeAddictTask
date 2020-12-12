//
//  MainVC.swift
//  CodeAddictTask
//
//  Created by Jakub Homik on 09/12/2020.
//

import UIKit

class MainVC: UIViewController {
    
    private(set) var activityIndicator = UIActivityIndicatorView()
    private(set) var containerView = UIView()
    private let tableView = UITableView()
    private let networkManager = NetworkManager()
    private(set) var cachedRepositories: [String:[Repositories]] = [:]
    private(set) var filteredRepositories: [Repositories] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureMainVC()
        configureSearchController()
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigationBarMainVC()
    }
    
    private func configureNavigationBarMainVC() {
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.view.backgroundColor = .systemBackground
    }
    
    private func configureMainVC() {
        title = Constants.mainTitle
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func configureSearchController() {
        let searchController = UISearchController()
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = Constants.searchForRepo
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
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
        perform(#selector(reload), with: searchBar, afterDelay: 0.5)
    }
    
    @objc func reload(_ searchBar: UISearchBar) {
        guard let query = searchBar.text, query.trimmingCharacters(in: .whitespaces) != "" else { return filteredRepositories.removeAll() }
        showLoadingSpinner(with: containerView, spinner: activityIndicator)
        if let previouslySearchedRepo = cachedRepositories[searchBar.text ?? ""] {
            filteredRepositories = previouslySearchedRepo
        } else {
            networkManager.searchRepositories(withWord: query, completion: { [weak self] (result) in
                guard let self = self else { return }
                self.dismissLoadingSpinner(with: self.containerView, spinner: self.activityIndicator)
                switch result {
                case .success(let repositories):
                    print(repositories)
                    DispatchQueue.main.async {
                        self.filteredRepositories = repositories.items
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            })
           }
        print(query)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        filteredRepositories.removeAll()
    }
}


