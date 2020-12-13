//
//  CircleNumberView.swift
//  CodeAddictTask
//
//  Created by Jakub Homik on 09/12/2020.
//

import UIKit

final class CircleNumberView: UIView {
    
    let numberOfCommit = MainCustomLabel(size: 17, weight: .medium)

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCircleNumberView()
        configureNumberOfCommit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.frame.height / 2
    }
    
    private func configureCircleNumberView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.clipsToBounds = true
        self.backgroundColor = UIColor.circleNumberViewBackgroundColor
    }
    
    private func configureNumberOfCommit() {
        self.addSubview(numberOfCommit)
        numberOfCommit.translatesAutoresizingMaskIntoConstraints = false
    
        NSLayoutConstraint.activate([
            numberOfCommit.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            numberOfCommit.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
}
