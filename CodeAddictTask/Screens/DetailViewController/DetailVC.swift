//
//  DetailVC.swift
//  CodeAddictTask
//
//  Created by Jakub Homik on 09/12/2020.
//

import UIKit

final class DetailVC: UIViewController {
    
    lazy var detailView = DetailView(viewModel: viewModel)
    private(set) var viewModel = DetailViewModel()
    private let activityIndicator = UIActivityIndicatorView()
    private let containerView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        detailView.delegate = self
    }
    
    override func loadView() {
        self.view = detailView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureDetailVC()
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

extension DetailVC: ShareRepoButtonDelegate {
    func share() {
        shareRepository()
    }
}

extension DetailVC: DetailUpdateDelegate {
    
    func showloadingSpinner() {
        showLoadingSpinner(with: containerView, spinner: activityIndicator)
    }
    
    func hideLoadingSpinner() {
        dismissLoadingSpinner(with: containerView, spinner: activityIndicator)
    }
}
