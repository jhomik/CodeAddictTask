//
//  MainCustomCell.swift
//  CodeAddictTask
//
//  Created by Jakub Homik on 09/12/2020.
//

import UIKit

class MainCustomCell: UITableViewCell {
    
    private let userAvatarImageView = UserAvatarImageView(frame: .zero)
    private let userRepositoryTitle = MainCustomLabel(size: 17, weight: .semibold)
    private let repositoryStarImageView = RepositoryStarImageView(frame: .zero)
    private let numberOfRepositoryStars = MainCustomLabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureMainCustomCell()
        configureUserAvataImageView()
        configureUserRepositoryTitle()
        configureRepositoryStarImageView()
        configureNumberOfRepositoryStars()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func updateCell() {
        userRepositoryTitle.text = "Jakub Homik"
        numberOfRepositoryStars.text = "345"
    }
    
    private func configureMainCustomCell() {
        self.clipsToBounds = true
        self.layer.cornerRadius = 13
        self.backgroundColor = UIColor.cellBackgroundColor
        self.accessoryType = .disclosureIndicator
    }
    
    private func configureUserAvataImageView() {
        self.addSubview(userAvatarImageView)
        userAvatarImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            userAvatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            userAvatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            userAvatarImageView.widthAnchor.constraint(equalToConstant: 60),
            userAvatarImageView.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    private func configureUserRepositoryTitle() {
        self.addSubview(userRepositoryTitle)
        userRepositoryTitle.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            userRepositoryTitle.topAnchor.constraint(equalTo: userAvatarImageView.topAnchor, constant: 10),
            userRepositoryTitle.leadingAnchor.constraint(equalTo: userAvatarImageView.trailingAnchor, constant: 16),
            userRepositoryTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 16),
            userRepositoryTitle.heightAnchor.constraint(equalToConstant: 22)
        ])
    }
    
    private func configureRepositoryStarImageView() {
        self.addSubview(repositoryStarImageView)
        repositoryStarImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            repositoryStarImageView.topAnchor.constraint(equalTo: userRepositoryTitle.bottomAnchor, constant: 4),
            repositoryStarImageView.leadingAnchor.constraint(equalTo: userAvatarImageView.trailingAnchor, constant: 16),
            repositoryStarImageView.heightAnchor.constraint(equalToConstant: 14),
            repositoryStarImageView.widthAnchor.constraint(equalToConstant: 14)
        ])
    }
    
    private func configureNumberOfRepositoryStars() {
        self.addSubview(numberOfRepositoryStars)
        numberOfRepositoryStars.translatesAutoresizingMaskIntoConstraints = false
        numberOfRepositoryStars.textColor = UIColor.numbersOfStarsColor
        
        NSLayoutConstraint.activate([
            numberOfRepositoryStars.topAnchor.constraint(equalTo: userRepositoryTitle.bottomAnchor),
            numberOfRepositoryStars.leadingAnchor.constraint(equalTo: repositoryStarImageView.trailingAnchor, constant: 4),
            numberOfRepositoryStars.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 16),
            numberOfRepositoryStars.heightAnchor.constraint(equalToConstant: 22)
        ])
    }
}
