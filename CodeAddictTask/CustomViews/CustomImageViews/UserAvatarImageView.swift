//
//  UserAvatarImageView.swift
//  CodeAddictTask
//
//  Created by Jakub Homik on 09/12/2020.
//

import UIKit

class UserAvatarImageView: UIImageView {
    
    let placeholder = Images.userAvatarImagePlaceHolder
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUserAvatarImageView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUserAvatarImageView() {
        self.image = placeholder
        self.contentMode = .scaleAspectFit
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
    }
}
