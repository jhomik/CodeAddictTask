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
        self.layer.cornerRadius = Margins.searchRepositoriesCustomCellCornerRadius
        self.backgroundColor = UIColor.cellBackgroundColor
    }
    
    private func configureUserAvataImageView() {
        contentView.addSubview(userAvatarImageView)
        userAvatarImageView.layer.cornerRadius = Margins.searchRepositoriesUserAvatarImageViewCornerRadius
        
        NSLayoutConstraint.activate([
            userAvatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Margins.searchRepositoriesUserAvatarImageViewTop),
            userAvatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Margins.searchRepositoriesUserAvatarImageViewLeading),
            userAvatarImageView.widthAnchor.constraint(equalToConstant: Margins.searchRepositoriesUserAvatarImageViewWidth),
            userAvatarImageView.heightAnchor.constraint(equalToConstant: Margins.searchRepositoriesUserAvatarImageViewHeight)
        ])
    }
    
    private func configureUserRepositoryTitleLabel() {
        contentView.addSubview(userRepositoryTitleLabel)
        
        NSLayoutConstraint.activate([
            userRepositoryTitleLabel.topAnchor.constraint(equalTo: userAvatarImageView.topAnchor, constant: Margins.userRepositoryTitleLabelTop),
            userRepositoryTitleLabel.leadingAnchor.constraint(equalTo: userAvatarImageView.trailingAnchor, constant: Margins.userRepositoryTitleLabelLeading),
            userRepositoryTitleLabel.widthAnchor.constraint(equalToConstant: Margins.userRepositoryTitleLabelWidth),
            userRepositoryTitleLabel.heightAnchor.constraint(equalToConstant: Margins.userRepositoryTitleLabelHeight)
        ])
    }
    
    private func configureRepositoryStarImageView() {
        repositoryStarImageView.image = Images.repositoryStarImage
        contentView.addSubview(repositoryStarImageView)
        repositoryStarImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            repositoryStarImageView.topAnchor.constraint(equalTo: userRepositoryTitleLabel.bottomAnchor, constant: Margins.repositoryStarImageViewTop),
            repositoryStarImageView.leadingAnchor.constraint(equalTo: userAvatarImageView.trailingAnchor, constant: Margins.repositoryStarImageViewLeading),
            repositoryStarImageView.heightAnchor.constraint(equalToConstant: Margins.repositoryStarImageViewHeight),
            repositoryStarImageView.widthAnchor.constraint(equalToConstant: Margins.repositoryStarImageViewWidth)
        ])
    }
    
    private func configureNumberOfRepositoryStarsLabel() {
        contentView.addSubview(numberOfRepositoryStarsLabel)
        numberOfRepositoryStarsLabel.textColor = UIColor.numbersOfStarsColor
        
        NSLayoutConstraint.activate([
            numberOfRepositoryStarsLabel.topAnchor.constraint(equalTo: userRepositoryTitleLabel.bottomAnchor),
            numberOfRepositoryStarsLabel.leadingAnchor.constraint(equalTo: repositoryStarImageView.trailingAnchor, constant: Margins.numberOfRepositoryStarsLabelLeading),
            numberOfRepositoryStarsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Margins.numberOfRepositoryStarsLabelTrailing),
            numberOfRepositoryStarsLabel.heightAnchor.constraint(equalToConstant: Margins.numberOfRepositoryStarsLabelHeight)
        ])
    }
    
    private func configureDisclosureIndicatorImage() {
        disclosureIndicatorImageView.image = Images.disclosureIndicatorImage
        contentView.addSubview(disclosureIndicatorImageView)
        disclosureIndicatorImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            disclosureIndicatorImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Margins.disclosureIndicatorImageViewTop),
            disclosureIndicatorImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: Margins.disclosureIndicatorImageViewTrailing),
            disclosureIndicatorImageView.widthAnchor.constraint(equalToConstant: Margins.disclosureIndicatorImageViewWidth),
            disclosureIndicatorImageView.heightAnchor.constraint(equalToConstant: Margins.disclosureIndicatorImageViewHeight)
        ])
    }
}
