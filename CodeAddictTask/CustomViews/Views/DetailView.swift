//
//  DetailView.swift
//  CodeAddictTask
//
//  Created by Jakub Homik on 09/12/2020.
//
protocol ViewOnlineButtonDelegate: AnyObject {
    func buttonTapped()
}

import UIKit

class DetailView: UIView {
    
    private let userAvatarImageView = UserAvatarImageView(frame: .zero)
    private let repositoryByLabel = MainCustomLabel(size: 15, weight: .semibold, color: UIColor.detailViewTitlesColor)
    private let repoAuthorNameLabel = MainCustomLabel(size: 28, weight: .bold, color: UIColor.detailViewTitlesColor)
    private let numberOfStarsLabel = MainCustomLabel(size: 13, weight: .regular, color: UIColor.detailViewTitlesColor)
    private let repositoryStarFillImageView = RepositoryStarFillImageView(frame: .zero)
    private let repositoryTitleLabel = MainCustomLabel(size: 17, weight: .semibold)
    private let viewOnlineButton = DetailCustomButton(radius: 17, fontSize: 15)
    private let commitsHistoryLabel = MainCustomLabel(size: 22, weight: .bold)
    weak var delegate: ViewOnlineButtonDelegate?
    var detailRepositories: DetailRepositories? {
        didSet {
            updateDetailRepositoriesView()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureDetailView()
        configureUserAvatarImageview()
        configureRepositoryByLabel()
        configureRepoAuthorNameLabel()
        configureRepositoryStarImageView()
        configureNumberOfStarsLabel()
        configureRepositoryTitleLabel()
        configureViewOnlineButton()
        configureCommitsHistoryLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func updateDetailRepositoriesView() {
        DispatchQueue.main.async {
            self.repositoryTitleLabel.text = self.detailRepositories?.name
            self.repoAuthorNameLabel.text = self.detailRepositories?.owner.login
            self.numberOfStarsLabel.text = String(self.detailRepositories?.stargazersCount ?? 0)
            self.userAvatarImageView.downloadImage(fromUrl: self.detailRepositories?.owner.avatarURL ?? "")
        }
    }
    
    private func configureDetailView() {
        self.translatesAutoresizingMaskIntoConstraints = false
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
    
    private func configureRepositoryStarImageView() {
        userAvatarImageView.addSubview(repositoryStarFillImageView)
        
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
    
    private func configureRepositoryTitleLabel() {
        self.addSubview(repositoryTitleLabel)
        
        NSLayoutConstraint.activate([
            repositoryTitleLabel.topAnchor.constraint(equalTo: userAvatarImageView.bottomAnchor, constant: 21),
            repositoryTitleLabel.leadingAnchor.constraint(equalTo: repositoryByLabel.leadingAnchor),
            repositoryTitleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            repositoryTitleLabel.heightAnchor.constraint(equalToConstant: 22)
        ])
    }
    
    private func configureViewOnlineButton() {
        self.addSubview(viewOnlineButton)
        viewOnlineButton.addTarget(self, action: #selector(onlineButtonTapped), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            viewOnlineButton.topAnchor.constraint(equalTo: userAvatarImageView.bottomAnchor, constant: 17),
            viewOnlineButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            viewOnlineButton.leadingAnchor.constraint(equalTo: repositoryTitleLabel.trailingAnchor, constant: 20),
            viewOnlineButton.widthAnchor.constraint(equalToConstant: 118),
            viewOnlineButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    @objc private func onlineButtonTapped() {
        delegate?.buttonTapped()
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
}
