//
//  DetailVC.swift
//  CodeAddictTask
//
//  Created by Jakub Homik on 09/12/2020.
//

import UIKit

final class DetailVC: UIViewController {
    
    private let activityIndicator = UIActivityIndicatorView()
    private let containerView = UIView()
    
    private(set) var viewModel = DetailViewModel()
    lazy var detailView = DetailView(viewModel: viewModel)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailView.viewOnlineTapped = self
        detailView.shareRepo = self
    }
    
    override func loadView() {
        self.view = detailView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureDetailVC()
        viewModel.detailDelegate = self
    }
    
    private func shareRepository() {
        guard let detailRepo = viewModel.detailRepositories, let url = URL(string: detailRepo.htmlUrl) else { return }
        let items: [Any] = [Constants.checkOutThisRepository + "\(detailRepo.name)", url]
        let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
        present(ac, animated: true)
    }
    
    private func configureDetailVC() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.view.backgroundColor = .clear
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.tintColor = UIColor.detailViewTitlesColor
        navigationController?.navigationBar.topItem?.backButtonTitle = Constants.backButton
    }
}

extension DetailVC: ViewOnlineButtonDelegate {
    
    func buttonTapped() {
        guard let detailRepo = viewModel.detailRepositories else { return }
        presentRepositoryOnSafari(with: detailRepo.htmlUrl)
    }
}

extension DetailVC: PassShareButtonDelegate {
    func shareTapped() {
        shareRepository()
    }
}

extension DetailVC: DetailUpdateDelegate {
    func presentAlertOnMainThread(title: String, message: String, buttonTitle: String) {
        presentAlert(title: title, message: message, buttonTitle: buttonTitle)
    }
    
    func showLoadingSpinner() {
        showLoadingSpinner(with: containerView, spinner: activityIndicator)
    }
    
    func hideLoadingSpinner() {
        dismissLoadingSpinner(with: containerView, spinner: activityIndicator)
    }
}
