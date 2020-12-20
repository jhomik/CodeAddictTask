//
//  DetailCustomCell.swift
//  CodeAddictTask
//
//  Created by Jakub Homik on 09/12/2020.
//

import UIKit

final class DetailCustomCell: UITableViewCell {
    
    let circleWithNumberView = CircleNumberView()
    private let commitAuthorNameLabel = MainCustomLabel(size: 11, weight: .semibold, color: UIColor.commitAuthorNameTitleColor)
    private let emailLabel = MainCustomLabel(size: 17, weight: .regular)
    private let commitMessageLabel = MainCustomLabel(size: 17, weight: .regular, color: UIColor.commitMessageTitleColor)

    var listOfCommits: ListCommit? {
        didSet {
            updateCell()
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureDetailCustomCell()
        configureCircleWithNumberView()
        configureCommitAuthorNameLabel()
        configureEmailLabel()
        configureCommitMessageLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureDetailCustomCell() {
        self.selectionStyle = .none
    }
    
    private func updateCell() {
        guard let commits = listOfCommits else { return }
        commitAuthorNameLabel.text = commits.commit.author.name
        emailLabel.text = commits.commit.author.email
        commitMessageLabel.text = commits.commit.message
    }
  
    private func configureCircleWithNumberView() {
        contentView.addSubview(circleWithNumberView)
        
        NSLayoutConstraint.activate([
            circleWithNumberView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 26),
            circleWithNumberView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            circleWithNumberView.widthAnchor.constraint(equalToConstant: 36),
            circleWithNumberView.heightAnchor.constraint(equalToConstant: 36)
        ])
    }
    
    private func configureCommitAuthorNameLabel() {
        commitAuthorNameLabel.textColor = UIColor.commitAuthorNameTitleColor
        contentView.addSubview(commitAuthorNameLabel)
        
        NSLayoutConstraint.activate([
            commitAuthorNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            commitAuthorNameLabel.leadingAnchor.constraint(equalTo: circleWithNumberView.trailingAnchor, constant: 20),
            commitAuthorNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            commitAuthorNameLabel.heightAnchor.constraint(equalToConstant: 13)
        ])
    }
    
    private func configureEmailLabel() {
        contentView.addSubview(emailLabel)
        
        NSLayoutConstraint.activate([
            emailLabel.topAnchor.constraint(equalTo: commitAuthorNameLabel.bottomAnchor, constant: 2),
            emailLabel.leadingAnchor.constraint(equalTo: circleWithNumberView.trailingAnchor, constant: 20),
            emailLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            emailLabel.heightAnchor.constraint(equalToConstant: 22)
        ])
    }
    
    private func configureCommitMessageLabel() {
        commitMessageLabel.textColor = UIColor.commitMessageTitleColor
        commitMessageLabel.numberOfLines = 0
        commitMessageLabel.lineBreakMode = .byTruncatingTail
        contentView.addSubview(commitMessageLabel)
        
        NSLayoutConstraint.activate([
            commitMessageLabel.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 2),
            commitMessageLabel.leadingAnchor.constraint(equalTo: circleWithNumberView.trailingAnchor, constant: 20),
            commitMessageLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            commitMessageLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            commitMessageLabel.heightAnchor.constraint(lessThanOrEqualToConstant: 44)
        ])
    }
}
