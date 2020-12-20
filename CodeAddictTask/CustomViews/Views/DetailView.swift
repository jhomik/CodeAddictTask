//
//  DetailView.swift
//  CodeAddictTask
//
//  Created by Jakub Homik on 09/12/2020.
//

import UIKit

protocol ViewOnlineButtonDelegate: AnyObject {
    func buttonTapped()
}

protocol PassShareButtonDelegate: AnyObject {
    func shareTapped()
}

final class DetailView: UIView {
    
    private let userAvatarImageView = UserAvatarImageView(frame: .zero)
    private let repositoryByLabel = MainCustomLabel(size: 15, weight: .semibold, color: UIColor.detailViewTitlesColor)
    private let repoAuthorNameLabel = MainCustomLabel(size: 28, weight: .bold, color: UIColor.detailViewTitlesColor)
    private let numberOfStarsLabel = MainCustomLabel(size: 13, weight: .regular, color: UIColor.detailViewTitlesColor)
    private let repositoryStarFillImageView = UIImageView()
    private let repositoryTitleLabel = MainCustomLabel(size: 17, weight: .semibold)
    private let viewOnlineButton = DetailCustomButton(radius: 17, fontSize: 15)
    private let commitsHistoryLabel = MainCustomLabel(size: 22, weight: .bold)
    private let tableView = UITableView()
    private let detailShareRepoView = DetailShareRepoView()
    private let viewModel: DetailViewModel
    
    lazy var detailTableViewDataSource = DetailTableViewDataSource(viewModel: viewModel)
    lazy var detailTableViewDelegate = DetailTableViewDelegate(viewModel: viewModel)
    
    weak var viewOnlineTapped: ViewOnlineButtonDelegate?
    weak var shareRepo: PassShareButtonDelegate?
    
    var detailRepositories: DetailRepositories? {
        didSet {
            updateDetailRepositoriesView()
        }
    }
    
    init(viewModel: DetailViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        viewModel.updateCommitsMessages = self
        viewModel.updateDetails = self
        detailShareRepoView.delegate = self
        configureDetailView()
        configureUserAvatarImageview()
        configureRepositoryByLabel()
        configureRepoAuthorNameLabel()
        configureRepositoryStarFillImageView()
        configureNumberOfStarsLabel()
        configureViewOnlineButton()
        configureRepositoryTitleLabel()
        configureCommitsHistoryLabel()
        configureDetailShareRepoView()
        configureTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func updateDetailRepositoriesView() {
        repositoryTitleLabel.text = detailRepositories?.name
        repoAuthorNameLabel.text = detailRepositories?.owner.login
        numberOfStarsLabel.text = String(detailRepositories?.stargazersCount ?? 0)
        userAvatarImageView.downloadImage(fromUrl: detailRepositories?.owner.avatarURL ?? "")
    }
    
    private func configureDetailView() {
        self.backgroundColor = .systemBackground
    }
    
    private func configureUserAvatarImageview() {
        self.addSubview(userAvatarImageView)
        userAvatarImageView.contentMode = .scaleAspectFill
        
        NSLayoutConstraint.activate([
            userAvatarImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: -4),
            userAvatarImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            userAvatarImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            userAvatarImageView.heightAnchor.constraint(equalToConstant: 263)
        ])
    }
    
    private func configureRepositoryByLabel() {
        userAvatarImageView.addSubview(repositoryByLabel)
        repositoryByLabel.text = Constants.repoBy
        repositoryByLabel.alpha = 0.6
        
        NSLayoutConstraint.activate([
            repositoryByLabel.topAnchor.constraint(equalTo: self.topAnchor,constant: 159),
            repositoryByLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            repositoryByLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            repositoryByLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    private func configureRepoAuthorNameLabel() {
        userAvatarImageView.addSubview(repoAuthorNameLabel)
        
        NSLayoutConstraint.activate([
            repoAuthorNameLabel.topAnchor.constraint(equalTo: repositoryByLabel.bottomAnchor, constant: 4),
            repoAuthorNameLabel.leadingAnchor.constraint(equalTo: repositoryByLabel.leadingAnchor),
            repoAuthorNameLabel.trailingAnchor.constraint(equalTo: repositoryByLabel.trailingAnchor),
            repoAuthorNameLabel.heightAnchor.constraint(equalToConstant: 34)
        ])
    }
    
    private func configureRepositoryStarFillImageView() {
        repositoryStarFillImageView.image = Images.repositoryStarFillImage
        userAvatarImageView.addSubview(repositoryStarFillImageView)
        repositoryStarFillImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            repositoryStarFillImageView.topAnchor.constraint(equalTo: repoAuthorNameLabel.bottomAnchor, constant: 9),
            repositoryStarFillImageView.leadingAnchor.constraint(equalTo: repositoryByLabel.leadingAnchor),
            repositoryStarFillImageView.widthAnchor.constraint(equalToConstant: 13),
            repositoryStarFillImageView.heightAnchor.constraint(equalToConstant: 13)
        ])
    }
    
    private func configureNumberOfStarsLabel() {
        userAvatarImageView.addSubview(numberOfStarsLabel)
        numberOfStarsLabel.alpha = 0.5
        
        NSLayoutConstraint.activate([
            numberOfStarsLabel.topAnchor.constraint(equalTo: repoAuthorNameLabel.bottomAnchor, constant: 6),
            numberOfStarsLabel.leadingAnchor.constraint(equalTo: repositoryStarFillImageView.trailingAnchor, constant: 5),
            numberOfStarsLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            numberOfStarsLabel.heightAnchor.constraint(equalToConstant: 18)
        ])
    }
    
    private func configureViewOnlineButton() {
        self.addSubview(viewOnlineButton)
        viewOnlineButton.addTarget(self, action: #selector(onlineButtonTapped), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            viewOnlineButton.topAnchor.constraint(equalTo: userAvatarImageView.bottomAnchor, constant: 17),
            viewOnlineButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            viewOnlineButton.widthAnchor.constraint(equalToConstant: 118),
            viewOnlineButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    @objc private func onlineButtonTapped() {
        viewOnlineTapped?.buttonTapped()
    }
    
    private func configureRepositoryTitleLabel() {
        self.addSubview(repositoryTitleLabel)
        
        NSLayoutConstraint.activate([
            repositoryTitleLabel.topAnchor.constraint(equalTo: userAvatarImageView.bottomAnchor, constant: 21),
            repositoryTitleLabel.leadingAnchor.constraint(equalTo: repositoryByLabel.leadingAnchor),
            repositoryTitleLabel.trailingAnchor.constraint(equalTo: viewOnlineButton.leadingAnchor, constant: -15),
            repositoryTitleLabel.heightAnchor.constraint(equalToConstant: 22)
        ])
    }
    
    private func configureCommitsHistoryLabel() {
        self.addSubview(commitsHistoryLabel)
        commitsHistoryLabel.text = Constants.commitsHistory
        
        NSLayoutConstraint.activate([
            commitsHistoryLabel.topAnchor.constraint(equalTo: viewOnlineButton.bottomAnchor, constant: 35),
            commitsHistoryLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            commitsHistoryLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            commitsHistoryLabel.heightAnchor.constraint(equalToConstant: 28)
        ])
    }
    
    private func configureDetailShareRepoView() {
        self.addSubview(detailShareRepoView)
        
        NSLayoutConstraint.activate([
            detailShareRepoView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            detailShareRepoView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            detailShareRepoView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            detailShareRepoView.heightAnchor.constraint(equalToConstant: 94)
        ])
    }
    
    private func configureTableView() {
        self.addSubview(tableView)
        tableView.dataSource = detailTableViewDataSource
        tableView.delegate = detailTableViewDelegate
        tableView.register(DetailCustomCell.self, forCellReuseIdentifier: Constants.detailCellReuseId)
        tableView.estimatedRowHeight = 111
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 1))
        
        if DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Standard {
            tableView.isScrollEnabled = true
        } else {
            tableView.isScrollEnabled = false
        }
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: commitsHistoryLabel.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: detailShareRepoView.topAnchor, constant: -24)
        ])
    }
}

extension DetailView: ReloadDetailTableViewDelegate {
    func reloadTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension DetailView: ShareRepoButtonDelegate {
    func share() {
        shareRepo?.shareTapped()
    }
}

extension DetailView: UpdateDetailViewDelegate {
    func updateUI(with details: DetailRepositories) {
        detailRepositories = details
    }
}
