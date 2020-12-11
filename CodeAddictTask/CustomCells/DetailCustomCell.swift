//
//  DetailCustomCell.swift
//  CodeAddictTask
//
//  Created by Jakub Homik on 09/12/2020.
//

import UIKit

class DetailCustomCell: UITableViewCell {
    
    private let circleWithNumberView = CircleNumberView()
    private let commitAuthorNameLabel = MainCustomLabel(size: 11, weight: .semibold)
    private let emailLabel = MainCustomLabel(size: 17, weight: .regular)
    private let commitMessageLabel = MainCustomLabel(size: 17, weight: .regular)
    var detailRepositories: DetailRepositories? {
        didSet {
            updateCell()
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCircleWithNumberView()
        configureCommitAuthorNameLabel()
        configureEmailLabel()
        configureCommitMessageLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func updateCell() {
        commitAuthorNameLabel.text = "Jakub Homik"
        emailLabel.text = "345@wp.pl"
        commitMessageLabel.text = "dsfdsagaffdskfdfk kfdsjfsadkjf af asdkf sadkjf asdkjf kjabf kjasbf kas"
    }
    
    private func configureCircleWithNumberView() {
        self.addSubview(circleWithNumberView)
        
        NSLayoutConstraint.activate([
            circleWithNumberView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 26),
            circleWithNumberView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            circleWithNumberView.widthAnchor.constraint(equalToConstant: 36),
            circleWithNumberView.heightAnchor.constraint(equalToConstant: 36),
        ])
    }
    
    private func configureCommitAuthorNameLabel() {
        self.addSubview(commitAuthorNameLabel)
        commitAuthorNameLabel.textColor = UIColor.commitAuthorNameTitleColor
        
        NSLayoutConstraint.activate([
            commitAuthorNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            commitAuthorNameLabel.leadingAnchor.constraint(equalTo: circleWithNumberView.trailingAnchor, constant: 20),
            commitAuthorNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            commitAuthorNameLabel.heightAnchor.constraint(equalToConstant: 13),
        ])
    }
    
    private func configureEmailLabel() {
        self.addSubview(emailLabel)
        
        NSLayoutConstraint.activate([
            emailLabel.topAnchor.constraint(equalTo: commitAuthorNameLabel.bottomAnchor, constant: 2),
            emailLabel.leadingAnchor.constraint(equalTo: circleWithNumberView.trailingAnchor, constant: 20),
            emailLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            emailLabel.heightAnchor.constraint(equalToConstant: 22),
        ])
    }
    
    private func configureCommitMessageLabel() {
        self.addSubview(commitMessageLabel)
        commitMessageLabel.textColor = UIColor.commitMessageTitleColor
        
        NSLayoutConstraint.activate([
            commitMessageLabel.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 2),
            commitMessageLabel.leadingAnchor.constraint(equalTo: circleWithNumberView.trailingAnchor, constant: 20),
            commitMessageLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            commitMessageLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
}
