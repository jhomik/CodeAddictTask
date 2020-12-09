//
//  RepositoryStarImageView.swift
//  CodeAddictTask
//
//  Created by Jakub Homik on 09/12/2020.
//

import UIKit

class RepositoryStarImageView: UIImageView {
    
    private let repositoryImage = Images.repositoryStarImage
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureRepositoryStarImageView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureRepositoryStarImageView() {
        self.image = repositoryImage
    }
}
