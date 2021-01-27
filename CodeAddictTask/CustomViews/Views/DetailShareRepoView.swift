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
    
    private let shareRepoButton = DetailCustomButton(radius: Margines.shareRepoButtonCornerRadius, withTitle: nil, fontSize: Fonts.shareRepoButtonFontSize)
    private let shareRepoImageView = UIImageView()
    private let shareRepoLabel = MainCustomLabel(size: Fonts.shareRepoLabelFontSize, weight: .semibold, color: UIColor.detailCustomButtonTitleColor)
    
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
            shareRepoButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: Margines.shareRepoButtonBottom),
            shareRepoButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Margines.shareRepoButtonLeading),
            shareRepoButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: Margines.shareRepoButtonTrailing),
            shareRepoButton.heightAnchor.constraint(equalToConstant: Margines.shareRepoButtonHeight)
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
            shareRepoImageView.leadingAnchor.constraint(equalTo: shareRepoButton.leadingAnchor, constant: Margines.shareRepoImageViewLeading),
            shareRepoImageView.heightAnchor.constraint(equalToConstant: Margines.shareRepoImageViewHeight),
            shareRepoImageView.widthAnchor.constraint(equalToConstant: Margines.shareRepoImageViewWidth)
        ])
    }
    
    private func configureShareRepoLabel() {
        shareRepoButton.addSubview(shareRepoLabel)
        shareRepoLabel.textColor = UIColor.detailCustomButtonTitleColor
        shareRepoLabel.text = Constants.shareRepo

        NSLayoutConstraint.activate([
            shareRepoLabel.centerYAnchor.constraint(equalTo: shareRepoButton.centerYAnchor),
            shareRepoLabel.leadingAnchor.constraint(equalTo: shareRepoImageView.trailingAnchor, constant: Margines.shareRepoLabelLeading),
            shareRepoLabel.heightAnchor.constraint(equalToConstant: Margines.shareRepoLabelHeight),
            shareRepoLabel.widthAnchor.constraint(equalToConstant: Margines.shareRepoLabelWidth)
        ])
    }
}
