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
    weak var mainDelegate: MainUpdateDelegate?
    weak var updateSearchRepositories: ReloadMainTableViewDelegate?
    
    private(set) var currentPage = 1 {
        didSet {
            fetchMoreRepositories()
        }
    }
    
    private(set) var searchWord = String() {
        didSet {
            searchForRepositories()
        }
    }
    
    private(set) var filteredRepositories: [Repositories] = [] {
        didSet {
            updateSearchRepositories?.reloadTableView()
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
        if indexPath.section == currentPage * 60 - 2 {
            currentPage += 1
        }
    }
    
    func updateSearchWord(_ searchForWord: String?) {
        filteredRepositories.removeAll()
        guard let word = searchForWord else { return }
        searchWord = word
    }
    
    func rowSelectedAt(indexPath: IndexPath) {
        mainDelegate?.pushDetailViewControler(with: filteredRepositories[indexPath.section])
    }

    func searchForRepositories() {
        currentPage = 1
        mainDelegate?.showLoadingSpinner()
        networkManager.searchRepositories(withWord: searchWord, page: currentPage) { [weak self] (result) in
            guard let self = self else { return }
            self.mainDelegate?.hideLoadingSpinner()
            switch result {
            case .success(let repositories):
                if repositories.items.isEmpty {
                    self.mainDelegate?.presentAlertOnMainThread(title: Constants.somethingWentWrong, message: CustomErrors.noRepositoriesSearch.rawValue, buttonTitle: Constants.okTitle)
                } else {
                    DispatchQueue.main.async {
                        self.filteredRepositories = repositories.items
                    }
                }
            case .failure(let error):
                self.mainDelegate?.presentAlertOnMainThread(title: Constants.somethingWentWrong, message: error.rawValue, buttonTitle: Constants.okTitle)
            }
        }
    }
    
    func fetchMoreRepositories() {
        mainDelegate?.showLoadingSpinner()
        networkManager.searchRepositories(withWord: searchWord, page: currentPage) { [weak self] (result) in
            guard let self = self else { return }
            self.mainDelegate?.hideLoadingSpinner()
            switch result {
            case .success(let repositories):
                DispatchQueue.main.async {
                    self.filteredRepositories.append(contentsOf: repositories.items)
                }
            case.failure(let error):
                self.mainDelegate?.presentAlertOnMainThread(title: Constants.somethingWentWrong, message: error.rawValue, buttonTitle: Constants.okTitle)
            }
        }
    }
}
