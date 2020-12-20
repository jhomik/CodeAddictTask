//
//  MainViewModel.swift
//  CodeAddictTask
//
//  Created by Jakub Homik on 17/12/2020.
//

import Foundation

protocol MainUpdateDelegate: AnyObject {
    func showLoadingSpinner()
    func hideLoadingSpinner()
    func pushDetailViewControler(with repository: Repositories)
    func presentAlertOnMainThread(title: String, message: String, buttonTitle: String)
}

protocol ReloadMainTableViewDelegate: AnyObject {
    func reloadTableView()
}

final class MainViewModel {
    
    private let networkManager = NetworkManager()
    weak var delegate: MainUpdateDelegate?
    weak var updateRepositories: ReloadMainTableViewDelegate?

    private(set) var currentPage = 1 {
        didSet {
            searchForRepositories()
        }
    }
    
    private(set) var searchWord = String() {
        didSet {
            searchForRepositories()
        }
    }
    
    private(set) var filteredRepositories: [Repositories] = [] {
        didSet {
            updateRepositories?.reloadTableView()
        }
    }
    
    func cancelButtonTapped() {
        filteredRepositories.removeAll()
    }
    
    func checkSearchBar(_ word: String?) {
        guard let query = word, query.trimmingCharacters(in: .whitespaces) != "" else { return filteredRepositories.removeAll()
                }
        print(query)
    }
    
    func currentIndexPath(_ indexPath: IndexPath) {
        if indexPath.section == currentPage * 30 - 2 {
            currentPage += 1
        }
    }
    
    func updateSearchWord(_ searchForWord: String?) {
        filteredRepositories.removeAll()
        guard let word = searchForWord else { return }
        searchWord = word
    }
    
    func rowSelectedAt(indexPath: IndexPath) {
        delegate?.pushDetailViewControler(with: filteredRepositories[indexPath.section])
    }
    
    func searchForRepositories() {
        delegate?.showLoadingSpinner()
        networkManager.searchRepositories(withWord: searchWord, page: currentPage) { [weak self] (result) in
            guard let self = self else { return }
            self.delegate?.hideLoadingSpinner()
            switch result {
            case .success(let repositories):
                DispatchQueue.main.async {
                    if self.filteredRepositories.isEmpty {
                        self.filteredRepositories = repositories.items
                    } else {
                        self.filteredRepositories.append(contentsOf: repositories.items)
                    }
                }
            case .failure(let error):
                self.delegate?.presentAlertOnMainThread(title: "Something went wrong...", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
}
