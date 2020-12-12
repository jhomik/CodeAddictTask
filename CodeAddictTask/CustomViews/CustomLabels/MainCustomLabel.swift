//
//  MainCustomLabel.swift
//  CodeAddictTask
//
//  Created by Jakub Homik on 09/12/2020.
//

import UIKit

final class MainCustomLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureMainCustomLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(size: CGFloat, weight: UIFont.Weight, color: UIColor = UIColor.defaultMainColor) {
        self.init(frame: .zero)
        self.textColor = color
        self.font = UIFont.systemFont(ofSize: size, weight: weight)
    }
    
    private func configureMainCustomLabel() {
        self.numberOfLines = 0
        self.translatesAutoresizingMaskIntoConstraints = false
        self.textAlignment = .left
    }
}
