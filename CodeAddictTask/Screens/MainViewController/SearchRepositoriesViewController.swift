//
//  SearchRepositoriesViewController.swift
//  CodeAddictTask
//
//  Created by Jakub Homik on 09/12/2020.
//

import UIKit

final class SearchRepositoriesViewController: UIViewController {
    
    private let viewModel = SearchRepositoriesViewModel()
    private let activityIndicator = UIActivityIndicatorView()
    private let containerView = UIView()
    
    lazy private(set) var searchRepositoriesSearchBarDelegate = SearchRepositoriesSearchBarDelegate(viewModel: viewModel)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.searchRepositoriesDelegate = self
        configureMainVC()
        configureSearchController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigationBarMainVC()
    }
    
    override func loadView() {
        self.view = SearchRepositoriesView(viewModel: viewModel)
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
        searchController.searchBar.delegate = searchRepositoriesSearchBarDelegate
        searchController.searchBar.searchTextField.clearButtonMode = .never
        searchController.searchBar.placeholder = Constants.searchForRepo
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
    }
}

extension SearchRepositoriesViewController: SearchRepositoriesEventDelegate {
    func isLoading(_ loading: Bool) {
        if loading {
            showLoadingSpinner(with: containerView, spinner: activityIndicator)
        } else {
            dismissLoadingSpinner(with: containerView, spinner: activityIndicator)
        }
    }
    
    func present(title: String, message: String, buttonTitle: String) {
        presentAlert(title: title, message: message, buttonTitle: buttonTitle)
    }
    
    func push(with repository: Repositories) {
        let detailVC = DetailVC()
        detailVC.viewModel.repositoryTitle = repository
        navigationController?.pushViewController(detailVC, animated: true)
    }
}


