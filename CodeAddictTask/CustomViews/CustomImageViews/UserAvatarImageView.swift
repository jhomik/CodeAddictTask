//
//  UserAvatarImageView.swift
//  CodeAddictTask
//
//  Created by Jakub Homik on 09/12/2020.
//

import UIKit

final class UserAvatarImageView: UIImageView {
    
    private let placeholderUserAvatarImage = Images.userAvatarImagePlaceHolder
    private let networkManager = NetworkManager()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUserAvatarImageView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUserAvatarImageView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.image = placeholderUserAvatarImage
        self.contentMode = .scaleAspectFit
        self.clipsToBounds = true
    }
    
    func downloadImage(fromUrl url: String) {
        networkManager.downloadImage(from: url) { [weak self] (image) in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.image = image
            }
        }
    }
}
