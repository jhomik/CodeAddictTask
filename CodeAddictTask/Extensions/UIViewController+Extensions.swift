//
//  UIViewController+Extensions.swift
//  CodeAddictTask
//
//  Created by Jakub Homik on 11/12/2020.
//

import UIKit
import SafariServices

extension UIViewController {
    func showLoadingSpinner(with containerView: UIView, spinner: UIActivityIndicatorView) {
        spinner.style = .large
        containerView.backgroundColor = .systemBackground
        containerView.alpha = 0

        UIView.animate(withDuration: 0.25) {
            containerView.alpha = 0.8
        }

        view.addSubview(containerView)
        containerView.addSubview(spinner)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        spinner.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            containerView.widthAnchor.constraint(equalTo: view.widthAnchor),
            containerView.heightAnchor.constraint(equalTo: view.heightAnchor),
            spinner.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
        ])
        spinner.startAnimating()
    }

    func dismissLoadingSpinner(with containerView: UIView, spinner: UIActivityIndicatorView) {
        DispatchQueue.main.async {
            containerView.removeFromSuperview()
            spinner.stopAnimating()
        }
    }
    
    func presentRepositoryOnSafari(with stringURL: String) {
        guard let url = URL(string: stringURL) else { return }
        let safariVC = SFSafariViewController(url: url)
        safariVC.modalPresentationStyle = .popover
        present(safariVC, animated: true)
    }
}
