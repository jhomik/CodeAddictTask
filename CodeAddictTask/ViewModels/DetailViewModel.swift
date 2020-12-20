//
//  DetailViewModel.swift
//  CodeAddictTask
//
//  Created by Jakub Homik on 17/12/2020.
//

import Foundation

protocol DetailUpdateDelegate: AnyObject {
    func showLoadingSpinner()
    func hideLoadingSpinner()
    func presentAlertOnMainThread(title: String, message: String, buttonTitle: String)
}

protocol ReloadDetailTableViewDelegate: AnyObject {
    func reloadTableView()
}

protocol UpdateDetailViewDelegate: AnyObject {
    func updateUI(with details: DetailRepositories)
}

final class DetailViewModel {
    
    private let networkManager = NetworkManager()
    weak var detailDelegate: DetailUpdateDelegate?
    weak var updateCommitsMessages: ReloadDetailTableViewDelegate?
    weak var updateDetails: UpdateDetailViewDelegate?
    
    var repositoryTitle: Repositories? {
        didSet {
            downloadRepositories()
            downloadCommits()
        }
    }
    
    private(set) var detailRepositories: DetailRepositories? {
        didSet {
            guard let detailRepos = detailRepositories else { return }
            updateDetails?.updateUI(with: detailRepos)
        }
    }
    
    private(set) var listCommits: ListCommits = [] {
        didSet {
            updateCommitsMessages?.reloadTableView()
        }
    }
    
    func downloadRepositories() {
        detailDelegate?.showLoadingSpinner()
        networkManager.getRepositories(forOwner: repositoryTitle?.owner.login ?? "", repoName: repositoryTitle?.name ?? "") { [weak self] (result) in
            guard let self = self else { return }
            self.detailDelegate?.hideLoadingSpinner()
            switch result {
            case .success(let detailRepositories):
                DispatchQueue.main.async {
                    self.detailRepositories = detailRepositories
                }
            case .failure(let error):
                self.detailDelegate?.presentAlertOnMainThread(title: Constants.somethingWentWrong, message: error.rawValue, buttonTitle: Constants.okTitle)
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
                self.detailDelegate?.presentAlertOnMainThread(title: Constants.somethingWentWrong, message: error.rawValue, buttonTitle: Constants.okTitle)
            }
        }
    }
}
