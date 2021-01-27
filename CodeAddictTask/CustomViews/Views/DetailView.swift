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
    private let repositoryByLabel = MainCustomLabel(size: Fonts.repositoryByLabelFontSize, weight: .semibold, color: UIColor.detailViewTitlesColor)
    private let repoAuthorNameLabel = MainCustomLabel(size: Fonts.repoAuthorNameLabelFontSize, weight: .bold, color: UIColor.detailViewTitlesColor)
    private let numberOfStarsLabel = MainCustomLabel(size: Fonts.numberOfStarsLabelFontSize, weight: .regular, color: UIColor.detailViewTitlesColor)
    private let repositoryStarFillImageView = UIImageView()
    private let repositoryTitleLabel = MainCustomLabel(size: Fonts.repositoryTitleLabelFontSize, weight: .semibold)
    private let viewOnlineButton = DetailCustomButton(radius: Margines.viewOnlineButtonCornerRadius, fontSize: Fonts.viewOnlineButtonFontSize)
    private let commitsHistoryLabel = MainCustomLabel(size: Fonts.commitsHistoryLabelFontSize, weight: .bold)
    private let tableView = UITableView()
    private let detailShareRepoView = DetailShareRepoView()
    private let viewModel: DetailViewModel
    
    lazy private(set) var detailTableViewDataSource = DetailTableViewDataSource(viewModel: viewModel)
    lazy private(set) var detailTableViewDelegate = DetailTableViewDelegate(viewModel: viewModel)
    
    weak var viewOnlineTapped: ViewOnlineButtonDelegate?
    weak var shareRepo: PassShareButtonDelegate?
    
    private(set) var detailRepositories: DetailRepositories? {
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
            userAvatarImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: Margines.detailViewUserAvatarImageViewTop),
            userAvatarImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            userAvatarImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            userAvatarImageView.heightAnchor.constraint(equalToConstant: Margines.detailViewUserAvatarImageViewHeight)
        ])
    }
    
    private func configureRepositoryByLabel() {
        userAvatarImageView.addSubview(repositoryByLabel)
        repositoryByLabel.text = Constants.repoBy
        repositoryByLabel.alpha = Margines.repositoryByLabelAlpha
        
        NSLayoutConstraint.activate([
            repositoryByLabel.topAnchor.constraint(equalTo: self.topAnchor,constant: Margines.repositoryByLabelTop),
            repositoryByLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Margines.repositoryByLabelLeading),
            repositoryByLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: Margines.repositoryByLabelTrailing),
            repositoryByLabel.heightAnchor.constraint(equalToConstant: Margines.repositoryByLabelHeight)
        ])
    }
    
    private func configureRepoAuthorNameLabel() {
        userAvatarImageView.addSubview(repoAuthorNameLabel)
        
        NSLayoutConstraint.activate([
            repoAuthorNameLabel.topAnchor.constraint(equalTo: repositoryByLabel.bottomAnchor, constant: Margines.repoAuthorNameLabelTop),
            repoAuthorNameLabel.leadingAnchor.constraint(equalTo: repositoryByLabel.leadingAnchor),
            repoAuthorNameLabel.trailingAnchor.constraint(equalTo: repositoryByLabel.trailingAnchor),
            repoAuthorNameLabel.heightAnchor.constraint(equalToConstant: Margines.repoAuthorNameLabelHeight)
        ])
    }
    
    private func configureRepositoryStarFillImageView() {
        repositoryStarFillImageView.image = Images.repositoryStarFillImage
        userAvatarImageView.addSubview(repositoryStarFillImageView)
        repositoryStarFillImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            repositoryStarFillImageView.topAnchor.constraint(equalTo: repoAuthorNameLabel.bottomAnchor, constant: Margines.repositoryStarFillImageViewTop),
            repositoryStarFillImageView.leadingAnchor.constraint(equalTo: repositoryByLabel.leadingAnchor),
            repositoryStarFillImageView.widthAnchor.constraint(equalToConstant: Margines.repositoryStarFillImageViewWidth),
            repositoryStarFillImageView.heightAnchor.constraint(equalToConstant: Margines.repositoryStarFillImageViewHeight)
        ])
    }
    
    private func configureNumberOfStarsLabel() {
        userAvatarImageView.addSubview(numberOfStarsLabel)
        numberOfStarsLabel.alpha = Margines.numberOfStarsLabelAlpha
        
        NSLayoutConstraint.activate([
            numberOfStarsLabel.topAnchor.constraint(equalTo: repoAuthorNameLabel.bottomAnchor, constant: Margines.numberOfStarsLabelTop),
            numberOfStarsLabel.leadingAnchor.constraint(equalTo: repositoryStarFillImageView.trailingAnchor, constant: Margines.numberOfStarsLabelLeading),
            numberOfStarsLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            numberOfStarsLabel.heightAnchor.constraint(equalToConstant: Margines.numberOfStarsLabelHeight)
        ])
    }
    
    private func configureViewOnlineButton() {
        self.addSubview(viewOnlineButton)
        viewOnlineButton.addTarget(self, action: #selector(onlineButtonTapped), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            viewOnlineButton.topAnchor.constraint(equalTo: userAvatarImageView.bottomAnchor, constant: Margines.viewOnlineButtonTop),
            viewOnlineButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: Margines.viewOnlineButtonTrailing),
            viewOnlineButton.widthAnchor.constraint(equalToConstant: Margines.viewOnlineButtonWidth),
            viewOnlineButton.heightAnchor.constraint(equalToConstant: Margines.viewOnlineButtonHeight)
        ])
    }
    
    @objc private func onlineButtonTapped() {
        viewOnlineTapped?.buttonTapped()
    }
    
    private func configureRepositoryTitleLabel() {
        self.addSubview(repositoryTitleLabel)
        
        NSLayoutConstraint.activate([
            repositoryTitleLabel.topAnchor.constraint(equalTo: userAvatarImageView.bottomAnchor, constant: Margines.repositoryTitleLabelTop),
            repositoryTitleLabel.leadingAnchor.constraint(equalTo: repositoryByLabel.leadingAnchor),
            repositoryTitleLabel.trailingAnchor.constraint(equalTo: viewOnlineButton.leadingAnchor, constant: Margines.repositoryTitleLabelTrailing),
            repositoryTitleLabel.heightAnchor.constraint(equalToConstant: Margines.repositoryTitleLabelHeight)
        ])
    }
    
    private func configureCommitsHistoryLabel() {
        self.addSubview(commitsHistoryLabel)
        commitsHistoryLabel.text = Constants.commitsHistory
        
        NSLayoutConstraint.activate([
            commitsHistoryLabel.topAnchor.constraint(equalTo: viewOnlineButton.bottomAnchor, constant: Margines.commitsHistoryLabelTop),
            commitsHistoryLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Margines.commitsHistoryLabelLeading),
            commitsHistoryLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            commitsHistoryLabel.heightAnchor.constraint(equalToConstant: Margines.commitsHistoryLabelHeight)
        ])
    }
    
    private func configureDetailShareRepoView() {
        self.addSubview(detailShareRepoView)
        
        NSLayoutConstraint.activate([
            detailShareRepoView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            detailShareRepoView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            detailShareRepoView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            detailShareRepoView.heightAnchor.constraint(equalToConstant: Margines.detailShareRepoViewHeight)
        ])
    }
    
    private func configureTableView() {
        self.addSubview(tableView)
        tableView.dataSource = detailTableViewDataSource
        tableView.delegate = detailTableViewDelegate
        tableView.register(DetailCustomCell.self, forCellReuseIdentifier: Constants.detailCellReuseId)
        tableView.estimatedRowHeight = Margines.detailTableViewEstimatedRowHeight
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
            tableView.bottomAnchor.constraint(equalTo: detailShareRepoView.topAnchor, constant: Margines.detailTableViewBottom)
        ])
    }
}

extension DetailView: ReloadDetailDelegate {
    
    func reload() {
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
    
    func update(with details: DetailRepositories) {
        detailRepositories = details
    }
}
