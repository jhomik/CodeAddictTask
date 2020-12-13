//
//  DetailShareRepoView.swift
//  CodeAddictTask
//
//  Created by Jakub Homik on 10/12/2020.
//

import UIKit

protocol ShareRepoButtonDelegate: AnyObject {
    func share()
}

final class DetailShareRepoView: UIView {
    
    private let shareRepoButton = DetailCustomButton(radius: 10, withTitle: nil, fontSize: 17)
    private let shareRepoImageView = UIImageView()
    private let shareRepoLabel = MainCustomLabel(size: 17, weight: .semibold, color: UIColor.detailCustomButtonTitleColor)
    
    weak var delegate: ShareRepoButtonDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureDetailShareRepoView()
        configureShareRepoButton()
        configureShareRepoImageView()
        configureShareRepoLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureDetailShareRepoView() {
        self.translatesAutoresizingMaskIntoConstraints = false
    }

    private func configureShareRepoButton() {
        self.addSubview(shareRepoButton)
        shareRepoButton.addTarget(self, action: #selector(shareButtonTapped), for: .touchUpInside)

        NSLayoutConstraint.activate([
            shareRepoButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -44),
            shareRepoButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            shareRepoButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            shareRepoButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc private func shareButtonTapped() {
        delegate?.share()
    }
    
    private func configureShareRepoImageView() {
        shareRepoImageView.image = Images.shareRepoImage
        shareRepoButton.addSubview(shareRepoImageView)
        shareRepoImageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            shareRepoImageView.centerYAnchor.constraint(equalTo: shareRepoButton.centerYAnchor),
            shareRepoImageView.leadingAnchor.constraint(equalTo: shareRepoButton.leadingAnchor, constant: 113),
            shareRepoImageView.heightAnchor.constraint(equalToConstant: 18),
            shareRepoImageView.widthAnchor.constraint(equalToConstant: 18)
        ])
    }
    
    private func configureShareRepoLabel() {
        shareRepoButton.addSubview(shareRepoLabel)
        shareRepoLabel.textColor = UIColor.detailCustomButtonTitleColor
        shareRepoLabel.text = Constants.shareRepo

        NSLayoutConstraint.activate([
            shareRepoLabel.centerYAnchor.constraint(equalTo: shareRepoButton.centerYAnchor),
            shareRepoLabel.leadingAnchor.constraint(equalTo: shareRepoImageView.trailingAnchor, constant: 9),
            shareRepoLabel.heightAnchor.constraint(equalToConstant: 22),
            shareRepoLabel.widthAnchor.constraint(equalToConstant: 92)
        ])
    }
}
