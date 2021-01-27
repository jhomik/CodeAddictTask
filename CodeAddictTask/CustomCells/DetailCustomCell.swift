//
//  DetailCustomCell.swift
//  CodeAddictTask
//
//  Created by Jakub Homik on 09/12/2020.
//

import UIKit

final class DetailCustomCell: UITableViewCell {
    
    let circleWithNumberView = CircleNumberView()
    private let commitAuthorNameLabel = MainCustomLabel(size: Fonts.commitAuthorNameLabelFontSize, weight: .semibold, color: UIColor.commitAuthorNameTitleColor)
    private let emailLabel = MainCustomLabel(size: Fonts.emailLabelFontSize, weight: .regular)
    private let commitMessageLabel = MainCustomLabel(size: Fonts.commitMessageLabelFontSize, weight: .regular, color: UIColor.commitMessageTitleColor)

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
            circleWithNumberView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Margins.circleWithNumberViewTop),
            circleWithNumberView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Margins.circleWithNumberViewLeading),
            circleWithNumberView.widthAnchor.constraint(equalToConstant: Margins.circleWithNumberViewWidth),
            circleWithNumberView.heightAnchor.constraint(equalToConstant: Margins.circleWithNumberViewHeight)
        ])
    }
    
    private func configureCommitAuthorNameLabel() {
        commitAuthorNameLabel.textColor = UIColor.commitAuthorNameTitleColor
        contentView.addSubview(commitAuthorNameLabel)
        
        NSLayoutConstraint.activate([
            commitAuthorNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Margins.commitAuthorNameLabelTop),
            commitAuthorNameLabel.leadingAnchor.constraint(equalTo: circleWithNumberView.trailingAnchor, constant: Margins.commitAuthorNameLabelLeading),
            commitAuthorNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Margins.commitAuthorNameLabelTrailing),
            commitAuthorNameLabel.heightAnchor.constraint(equalToConstant: Margins.commitAuthorNameLabelHeight)
        ])
    }
    
    private func configureEmailLabel() {
        contentView.addSubview(emailLabel)
        
        NSLayoutConstraint.activate([
            emailLabel.topAnchor.constraint(equalTo: commitAuthorNameLabel.bottomAnchor, constant: Margins.emailLabelTop),
            emailLabel.leadingAnchor.constraint(equalTo: circleWithNumberView.trailingAnchor, constant: Margins.emailLabelLeading),
            emailLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Margins.emailLabelTrailing),
            emailLabel.heightAnchor.constraint(equalToConstant: Margins.emailLabelHeight)
        ])
    }
    
    private func configureCommitMessageLabel() {
        commitMessageLabel.textColor = UIColor.commitMessageTitleColor
        commitMessageLabel.numberOfLines = 0
        commitMessageLabel.lineBreakMode = .byTruncatingTail
        contentView.addSubview(commitMessageLabel)
        
        NSLayoutConstraint.activate([
            commitMessageLabel.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: Margins.commitMessageLabelTop),
            commitMessageLabel.leadingAnchor.constraint(equalTo: circleWithNumberView.trailingAnchor, constant: Margins.commitMessageLabelLeading),
            commitMessageLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Margins.commitMessageLabelTrailing),
            commitMessageLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: Margins.commitMessageLabelBottom),
            commitMessageLabel.heightAnchor.constraint(lessThanOrEqualToConstant: Margins.commitMessageLabelHeight)
        ])
    }
}
