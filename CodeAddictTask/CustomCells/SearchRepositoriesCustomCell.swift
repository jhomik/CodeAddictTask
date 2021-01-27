//
//  SearchRepositoriesCustomCell.swift
//  CodeAddictTask
//
//  Created by Jakub Homik on 09/12/2020.
//

import UIKit

final class SearchRepositoriesCustomCell: UITableViewCell {
    
    private let userAvatarImageView = UserAvatarImageView(frame: .zero)
    private let userRepositoryTitleLabel = MainCustomLabel(size: Fonts.userRepositoryTitleLabelFontSize, weight: .semibold)
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
        configureSearchRepositoriesCustomCell()
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
    
    private func configureSearchRepositoriesCustomCell() {
        self.clipsToBounds = true
        self.layer.cornerRadius = Margines.searchRepositoriesCustomCellCornerRadius
        self.backgroundColor = UIColor.cellBackgroundColor
    }
    
    private func configureUserAvataImageView() {
        contentView.addSubview(userAvatarImageView)
        userAvatarImageView.layer.cornerRadius = Margines.searchRepositoriesUserAvatarImageViewCornerRadius
        
        NSLayoutConstraint.activate([
            userAvatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Margines.searchRepositoriesUserAvatarImageViewTop),
            userAvatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Margines.searchRepositoriesUserAvatarImageViewLeading),
            userAvatarImageView.widthAnchor.constraint(equalToConstant: Margines.searchRepositoriesUserAvatarImageViewWidth),
            userAvatarImageView.heightAnchor.constraint(equalToConstant: Margines.searchRepositoriesUserAvatarImageViewHeight)
        ])
    }
    
    private func configureUserRepositoryTitleLabel() {
        contentView.addSubview(userRepositoryTitleLabel)
        
        NSLayoutConstraint.activate([
            userRepositoryTitleLabel.topAnchor.constraint(equalTo: userAvatarImageView.topAnchor, constant: Margines.userRepositoryTitleLabelTop),
            userRepositoryTitleLabel.leadingAnchor.constraint(equalTo: userAvatarImageView.trailingAnchor, constant: Margines.userRepositoryTitleLabelLeading),
            userRepositoryTitleLabel.widthAnchor.constraint(equalToConstant: Margines.userRepositoryTitleLabelWidth),
            userRepositoryTitleLabel.heightAnchor.constraint(equalToConstant: Margines.userRepositoryTitleLabelHeight)
        ])
    }
    
    private func configureRepositoryStarImageView() {
        repositoryStarImageView.image = Images.repositoryStarImage
        contentView.addSubview(repositoryStarImageView)
        repositoryStarImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            repositoryStarImageView.topAnchor.constraint(equalTo: userRepositoryTitleLabel.bottomAnchor, constant: Margines.repositoryStarImageViewTop),
            repositoryStarImageView.leadingAnchor.constraint(equalTo: userAvatarImageView.trailingAnchor, constant: Margines.repositoryStarImageViewLeading),
            repositoryStarImageView.heightAnchor.constraint(equalToConstant: Margines.repositoryStarImageViewHeight),
            repositoryStarImageView.widthAnchor.constraint(equalToConstant: Margines.repositoryStarImageViewWidth)
        ])
    }
    
    private func configureNumberOfRepositoryStarsLabel() {
        contentView.addSubview(numberOfRepositoryStarsLabel)
        numberOfRepositoryStarsLabel.textColor = UIColor.numbersOfStarsColor
        
        NSLayoutConstraint.activate([
            numberOfRepositoryStarsLabel.topAnchor.constraint(equalTo: userRepositoryTitleLabel.bottomAnchor),
            numberOfRepositoryStarsLabel.leadingAnchor.constraint(equalTo: repositoryStarImageView.trailingAnchor, constant: Margines.numberOfRepositoryStarsLabelLeading),
            numberOfRepositoryStarsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Margines.numberOfRepositoryStarsLabelTrailing),
            numberOfRepositoryStarsLabel.heightAnchor.constraint(equalToConstant: Margines.numberOfRepositoryStarsLabelHeight)
        ])
    }
    
    private func configureDisclosureIndicatorImage() {
        disclosureIndicatorImageView.image = Images.disclosureIndicatorImage
        contentView.addSubview(disclosureIndicatorImageView)
        disclosureIndicatorImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            disclosureIndicatorImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Margines.disclosureIndicatorImageViewTop),
            disclosureIndicatorImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: Margines.disclosureIndicatorImageViewTrailing),
            disclosureIndicatorImageView.widthAnchor.constraint(equalToConstant: Margines.disclosureIndicatorImageViewWidth),
            disclosureIndicatorImageView.heightAnchor.constraint(equalToConstant: Margines.disclosureIndicatorImageViewHeight)
        ])
    }
}
