//
//  MainCustomCell.swift
//  CodeAddictTask
//
//  Created by Jakub Homik on 09/12/2020.
//

import UIKit

final class MainCustomCell: UITableViewCell {
    
    private let userAvatarImageView = UserAvatarImageView(frame: .zero)
    private let userRepositoryTitleLabel = MainCustomLabel(size: 17, weight: .semibold)
    private let repositoryStarImageView = UIImageView()
    private let numberOfRepositoryStarsLabel = MainCustomLabel()
    private let disclosureIndicatorImageView = UIImageView()
    private let networkManager = NetworkManager()
    
    var repositories: Repositories? {
        didSet {
            updateCell()
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureMainCustomCell()
        configureUserAvataImageView()
        configureUserRepositoryTitleLabel()
        configureRepositoryStarImageView()
        configureNumberOfRepositoryStarsLabel()
        configureDisclosureIndicatorImage()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func updateCell() {
        guard let repo = repositories else { return }
        userRepositoryTitleLabel.text = repo.name
        numberOfRepositoryStarsLabel.text = String(repo.stargazersCount)
        userAvatarImageView.downloadImage(fromUrl: repo.owner.avatarURL ?? "")
    }
    
    private func configureMainCustomCell() {
        self.clipsToBounds = true
        self.layer.cornerRadius = 13
        self.backgroundColor = UIColor.cellBackgroundColor
    }
    
    private func configureUserAvataImageView() {
        contentView.addSubview(userAvatarImageView)
        userAvatarImageView.layer.cornerRadius = 10
        
        NSLayoutConstraint.activate([
            userAvatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            userAvatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            userAvatarImageView.widthAnchor.constraint(equalToConstant: 60),
            userAvatarImageView.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    private func configureUserRepositoryTitleLabel() {
        contentView.addSubview(userRepositoryTitleLabel)
        
        NSLayoutConstraint.activate([
            userRepositoryTitleLabel.topAnchor.constraint(equalTo: userAvatarImageView.topAnchor, constant: 10),
            userRepositoryTitleLabel.leadingAnchor.constraint(equalTo: userAvatarImageView.trailingAnchor, constant: 16),
            userRepositoryTitleLabel.widthAnchor.constraint(equalToConstant: 207),
            userRepositoryTitleLabel.heightAnchor.constraint(equalToConstant: 22)
        ])
    }
    
    private func configureRepositoryStarImageView() {
        repositoryStarImageView.image = Images.repositoryStarImage
        contentView.addSubview(repositoryStarImageView)
        repositoryStarImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            repositoryStarImageView.topAnchor.constraint(equalTo: userRepositoryTitleLabel.bottomAnchor, constant: 4),
            repositoryStarImageView.leadingAnchor.constraint(equalTo: userAvatarImageView.trailingAnchor, constant: 16),
            repositoryStarImageView.heightAnchor.constraint(equalToConstant: 14),
            repositoryStarImageView.widthAnchor.constraint(equalToConstant: 14)
        ])
    }
    
    private func configureNumberOfRepositoryStarsLabel() {
        contentView.addSubview(numberOfRepositoryStarsLabel)
        numberOfRepositoryStarsLabel.textColor = UIColor.numbersOfStarsColor
        
        NSLayoutConstraint.activate([
            numberOfRepositoryStarsLabel.topAnchor.constraint(equalTo: userRepositoryTitleLabel.bottomAnchor),
            numberOfRepositoryStarsLabel.leadingAnchor.constraint(equalTo: repositoryStarImageView.trailingAnchor, constant: 4),
            numberOfRepositoryStarsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 16),
            numberOfRepositoryStarsLabel.heightAnchor.constraint(equalToConstant: 22)
        ])
    }
    
    private func configureDisclosureIndicatorImage() {
        disclosureIndicatorImageView.image = Images.disclosureIndicatorImage
        contentView.addSubview(disclosureIndicatorImageView)
        disclosureIndicatorImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            disclosureIndicatorImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 39),
            disclosureIndicatorImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            disclosureIndicatorImageView.widthAnchor.constraint(equalToConstant: 8),
            disclosureIndicatorImageView.heightAnchor.constraint(equalToConstant: 13)
        ])
    }
}
