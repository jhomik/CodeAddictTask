//
//  DetailViewModel.swift
//  CodeAddictTask
//
//  Created by Jakub Homik on 17/12/2020.
//

import Foundation

protocol DetailUpdateDelegate: AnyObject {
    func isLoading(_ loading: Bool)
    func onErrorAlert(title: String, message: String, buttonTitle: String)
}

protocol ReloadDetailDelegate: AnyObject {
    func reload()
}

protocol UpdateDetailViewDelegate: AnyObject {
    func update(with details: DetailRepositories)
}

final class DetailViewModel {
    
    private let networkManager = NetworkManager()
    weak var detailDelegate: DetailUpdateDelegate?
    weak var updateCommitsMessages: ReloadDetailDelegate?
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
            updateDetails?.update(with: detailRepos)
        }
    }
    
    private(set) var listCommits: ListCommits = [] {
        didSet {
            updateCommitsMessages?.reload()
        }
    }
    
    func downloadRepositories() {
        detailDelegate?.isLoading(true)
        networkManager.getRepositories(forOwner: repositoryTitle?.owner.login ?? "", repoName: repositoryTitle?.name ?? "") { [weak self] (result) in
            guard let self = self else { return }
            self.detailDelegate?.isLoading(false)
            switch result {
            case .success(let detailRepositories):
                DispatchQueue.main.async {
                    self.detailRepositories = detailRepositories
                }
            case .failure(let error):
                self.detailDelegate?.onErrorAlert(title: Constants.somethingWentWrong, message: error.rawValue, buttonTitle: Constants.okTitle)
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
            case .failure:
                print(Constants.noCommits)
            }
        }
    }
}
