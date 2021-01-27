//
//  RepositoryHeaderView.swift
//  CodeAddictTask
//
//  Created by Jakub Homik on 09/12/2020.
//

import UIKit

final class RepositoryHeaderView: UIView {
    
    private let repositoryTitleLabel = MainCustomLabel(size: Fonts.headerViewRepositoryTitleLabelFontSize, weight: .bold)

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureRepositoryTitleLabe()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureRepositoryTitleLabe() {
        self.addSubview(repositoryTitleLabel)
        repositoryTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        repositoryTitleLabel.text = Constants.repositoryTitle
        repositoryTitleLabel.backgroundColor = .systemBackground
    
        NSLayoutConstraint.activate([
            repositoryTitleLabel.topAnchor.constraint(equalTo: self.topAnchor),
            repositoryTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            repositoryTitleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            repositoryTitleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
