//
//  MainView.swift
//  CodeAddictTask
//
//  Created by Jakub Homik on 19/12/2020.
//

import UIKit

final class SearchRepositoriesView: UIView {
    
    private let tableView = UITableView()
    private let viewModel: SearchRepositoriesViewModel
    
    lazy var searchRepositoriesTableViewDataSource = SearchRepositoriesTableViewDataSource(viewModel: viewModel)
    lazy var searchRepositoriesTableViewDelegate = SearchRepositoriesTableViewDelegate(viewModel: viewModel)
    
    init(viewModel: SearchRepositoriesViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        viewModel.updateSearchRepositories = self
        configureSearchRepositoriesView()
        configureTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureSearchRepositoriesView() {
        self.backgroundColor = .systemBackground
    }
    
    private func configureTableView() {
        self.addSubview(tableView)
        tableView.delegate = searchRepositoriesTableViewDelegate
        tableView.dataSource = searchRepositoriesTableViewDataSource
        tableView.separatorStyle = .none
        tableView.register(SearchRepositoriesCustomCell.self, forCellReuseIdentifier: Constants.mainCellReuseId)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Margins.searchRepositoriesTableViewLeading),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: Margins.searchRepositoriesTableViewTrailing),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}

extension SearchRepositoriesView: ReloadSearchRepositoriesDelegate {
    
    func reload() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
