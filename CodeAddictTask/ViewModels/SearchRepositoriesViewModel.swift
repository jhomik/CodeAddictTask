//
//  SearchRepositoriesViewModel.swift
//  CodeAddictTask
//
//  Created by Jakub Homik on 17/12/2020.
//

import Foundation

protocol SearchRepositoriesEventDelegate: AnyObject {
    func isLoading(_ loading: Bool)
    func push(with repository: Repositories)
    func present(title: String, message: String, buttonTitle: String)
}

protocol ReloadSearchRepositoriesDelegate: AnyObject {
    func reload()
}

final class SearchRepositoriesViewModel {
    
    private let networkManager = NetworkManager()
    weak var searchRepositoriesDelegate: SearchRepositoriesEventDelegate?
    weak var updateSearchRepositories: ReloadSearchRepositoriesDelegate?
    
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
            updateSearchRepositories?.reload()
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
        searchRepositoriesDelegate?.push(with: filteredRepositories[indexPath.section])
    }

    func searchForRepositories() {
        currentPage = 1
        searchRepositoriesDelegate?.isLoading(true)
        networkManager.searchRepositories(withWord: searchWord, page: currentPage) { [weak self] (result) in
            guard let self = self else { return }
            self.searchRepositoriesDelegate?.isLoading(false)
            switch result {
            case .success(let repositories):
                if repositories.items.isEmpty {
                    self.searchRepositoriesDelegate?.present(title: Constants.somethingWentWrong, message: CustomErrors.noRepositoriesSearch.rawValue, buttonTitle: Constants.okTitle)
                } else {
                    DispatchQueue.main.async {
                        self.filteredRepositories = repositories.items
                    }
                }
            case .failure(let error):
                self.searchRepositoriesDelegate?.present(title: Constants.somethingWentWrong, message: error.rawValue, buttonTitle: Constants.okTitle)
            }
        }
    }
    
    func fetchMoreRepositories() {
        searchRepositoriesDelegate?.isLoading(true)
        networkManager.searchRepositories(withWord: searchWord, page: currentPage) { [weak self] (result) in
            guard let self = self else { return }
            self.searchRepositoriesDelegate?.isLoading(false)
            switch result {
            case .success(let repositories):
                DispatchQueue.main.async {
                    self.filteredRepositories.append(contentsOf: repositories.items)
                }
            case.failure(let error):
                self.searchRepositoriesDelegate?.present(title: Constants.somethingWentWrong, message: error.rawValue, buttonTitle: Constants.okTitle)
            }
        }
    }
}
