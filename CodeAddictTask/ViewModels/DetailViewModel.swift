//
//  DetailViewModel.swift
//  CodeAddictTask
//
//  Created by Jakub Homik on 17/12/2020.
//

import Foundation

protocol DetailUpdateDelegate: AnyObject {
    func showloadingSpinner()
    func hideLoadingSpinner()
}

protocol ReloadDetailTableViewDelegate: AnyObject {
    func reloadTableView()
}

protocol UpdateDetailViewDelegate: AnyObject {
    func updateUI(with details: DetailRepositories)
}

class DetailViewModel {
    
    private let networkManager = NetworkManager()
    weak var delegate: DetailUpdateDelegate?
    weak var reloadTableView: ReloadDetailTableViewDelegate?
    
    var repositoryTitle: Repositories? {
        didSet {
            downloadRepositories()
            downloadCommits()
        }
    }
    
    private(set) var detailRepositories: DetailRepositories? {
        didSet {
//            detailView.detailRepositories = detailRepositories
        }
    }
    
    private(set) var listCommits: ListCommits = [] {
        didSet {
            reloadTableView?.reloadTableView()
        }
    }
    
    func downloadRepositories() {
        delegate?.showloadingSpinner()
        networkManager.getRepositories(forOwner: repositoryTitle?.owner.login ?? "", repoName: repositoryTitle?.name ?? "") { [weak self] (result) in
            guard let self = self else { return }
            self.delegate?.hideLoadingSpinner()
            switch result {
            case .success(let detailRepositories):
                DispatchQueue.main.async {
                    self.detailRepositories = detailRepositories
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func downloadCommits() {
        networkManager.getListCommits(forOwner: repositoryTitle?.owner.login ?? "" , repoName: repositoryTitle?.name ?? "") { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let commits):
                DispatchQueue.main.async {
                    self.listCommits = commits
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
