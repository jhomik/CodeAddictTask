//
//  MainVC.swift
//  CodeAddictTask
//
//  Created by Jakub Homik on 09/12/2020.
//

import UIKit

final class MainVC: UIViewController {
    
    private let viewModel = MainViewModel()
    private let activityIndicator = UIActivityIndicatorView()
    private let containerView = UIView()
    
    lazy var mainSearchBarDelegate = MainSearchBarDelegate(viewModel: viewModel)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.mainDelegate = self
        configureMainVC()
        configureSearchController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigationBarMainVC()
    }
    
    override func loadView() {
        self.view = MainView(viewModel: viewModel)
    }
    
    private func configureNavigationBarMainVC() {
        title = Constants.mainTitle
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.view.backgroundColor = .systemBackground
        navigationController?.navigationBar.barStyle = .default
        navigationController?.navigationBar.tintColor = .none
    }
    
    private func configureMainVC() {
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func configureSearchController() {
        let searchController = UISearchController()
        searchController.searchBar.delegate = mainSearchBarDelegate
        searchController.searchBar.searchTextField.clearButtonMode = .never
        searchController.searchBar.placeholder = Constants.searchForRepo
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
    }
}

extension MainVC: MainUpdateDelegate {
    
    func presentAlertOnMainThread(title: String, message: String, buttonTitle: String) {
        presentAlert(title: title, message: message, buttonTitle: buttonTitle)
    }
    
    func showLoadingSpinner() {
        showLoadingSpinner(with: containerView, spinner: activityIndicator)
    }
    
    func hideLoadingSpinner() {
        dismissLoadingSpinner(with: containerView, spinner: activityIndicator)
    }
    
    func pushDetailViewControler(with repository: Repositories) {
        let detailVC = DetailVC()
        detailVC.viewModel.repositoryTitle = repository
        navigationController?.pushViewController(detailVC, animated: true)
    }
}


