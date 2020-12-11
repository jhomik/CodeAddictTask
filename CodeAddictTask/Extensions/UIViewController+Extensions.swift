//
//  UIViewController+Extensions.swift
//  CodeAddictTask
//
//  Created by Jakub Homik on 11/12/2020.
//

import UIKit

extension UIViewController {
    
    func showLoadingSpinner(with containerView: UIView) {
        containerView.frame = view.bounds
        containerView.backgroundColor = .systemBackground
        containerView.alpha = 0

        UIView.animate(withDuration: 0.25) {
            containerView.alpha = 0.8
        }

        let activityIndicator = UIActivityIndicatorView(style: .large)

        view.addSubview(containerView)
        containerView.addSubview(activityIndicator)

        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        activityIndicator.startAnimating()
    }

    func dismissLoadingSpinner(with containerView: UIView) {
        DispatchQueue.main.async {
            containerView.removeFromSuperview()
        }
    }
}
