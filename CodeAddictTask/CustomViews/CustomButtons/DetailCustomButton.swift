//
//  DetailCustomButton.swift
//  CodeAddictTask
//
//  Created by Jakub Homik on 10/12/2020.
//

import UIKit

final class DetailCustomButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureDetailCustomButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(radius: CGFloat, withTitle: String? = Constants.viewOnline, fontSize: CGFloat) {
        self.init(frame: .zero)
        self.titleLabel?.font = UIFont.systemFont(ofSize: fontSize, weight: .semibold)
        self.setTitle(withTitle, for: .normal)
        self.layer.cornerRadius = radius
    }
    
    private func configureDetailCustomButton() { 
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = UIColor.detailCustomButtonBackgroundColor
        self.titleLabel?.textAlignment = .center
        self.setTitleColor(.detailCustomButtonTitleColor, for: .normal)
    }
}
