//
//  MainVC.swift
//  CodeAddictTask
//
//  Created by Jakub Homik on 09/12/2020.
//

import UIKit

final class MainVC: UIViewController {
    
    private let viewModel = MainViewModel()
    private let mainSearchBarDelegate = MainSearchBarDelegate()
    private let activityIndicator = UIActivityIndicatorView()
    private let containerView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainSearchBarDelegate.viewModel = viewModel
        viewModel.delegate = self
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
        navigationController?.view.backgroundColor = .systemBackground
        navigationController?.navigationBar.barStyle = .default
        navigationController?.navigationBar.tintColor = .none
    }
    
    private func configureMainVC() {
//        view.backgroundColor = .systemBackground
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

