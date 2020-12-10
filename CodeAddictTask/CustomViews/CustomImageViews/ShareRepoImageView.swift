//
//  ShareRepoImageView.swift
//  CodeAddictTask
//
//  Created by Jakub Homik on 10/12/2020.
//

import UIKit

class ShareRepoImageView: UIImageView {

    private let shareRepoImage = Images.shareRepoImage
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureShareRepoImage()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureShareRepoImage() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.image = shareRepoImage
    }
}
