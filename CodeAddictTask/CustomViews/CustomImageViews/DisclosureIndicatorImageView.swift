//
//  DisclosureIndicatorImageView.swift
//  CodeAddictTask
//
//  Created by Jakub Homik on 09/12/2020.
//

import UIKit

final class DisclosureIndicatorImageView: UIImageView {

    private let disclosureIndicatorImage = Images.disclosureIndicatorImage
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureRepositoryStarImageView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureRepositoryStarImageView() {
        self.image = disclosureIndicatorImage
    }
}
