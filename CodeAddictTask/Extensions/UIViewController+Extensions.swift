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
        DispatchQueue.main.async {
            spinner.style = .large
            containerView.backgroundColor = .systemBackground
            containerView.alpha = 0
            
            UIView.animate(withDuration: 0.25) {
                containerView.alpha = 0.8
            }
            
            self.view.addSubview(containerView)
            containerView.addSubview(spinner)
            containerView.translatesAutoresizingMaskIntoConstraints = false
            spinner.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                containerView.widthAnchor.constraint(equalTo: self.view.widthAnchor),
                containerView.heightAnchor.constraint(equalTo: self.view.heightAnchor),
                spinner.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
                spinner.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            ])
            spinner.startAnimating()
        }
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
    
    func presentAlert(title: String, message: String, buttonTitle: String) {
        DispatchQueue.main.async {
            let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: buttonTitle, style: .default, handler: { _ in
                self.navigationController?.popViewController(animated: true)
            }))
            self.present(alertVC, animated: true)
        }
    }
}
