//
//  MainCustomLabel.swift
//  CodeAddictTask
//
//  Created by Jakub Homik on 09/12/2020.
//

import UIKit

class MainCustomLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureMainCustomLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureMainCustomLabel() {
        self.textAlignment = .left
    }
    
    convenience init(size: CGFloat, weight: UIFont.Weight) {
        self.init(frame: .zero)
        self.font = UIFont.systemFont(ofSize: size, weight: weight)
    }
}
