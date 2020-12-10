//
//  RepositoryStarFillImageView.swift
//  CodeAddictTask
//
//  Created by Jakub Homik on 09/12/2020.
//

import UIKit

class RepositoryStarFillImageView: UIImageView {
    
    private let repositoryImage = Images.repositoryStarFillImage
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureRepositoryStarFillImageView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureRepositoryStarFillImageView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.image = repositoryImage
    }
}
