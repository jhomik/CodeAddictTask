//
//  MainView.swift
//  CodeAddictTask
//
//  Created by Jakub Homik on 19/12/2020.
//

import UIKit

final class MainView: UIView {

    private let tableView = UITableView()
    private let viewModel: MainViewModel
    
    lazy var mainTableViewDataSource = MainTableViewDataSource(viewModel: viewModel)
    lazy var mainTableViewDelegate = MainTableViewDelegate(viewModel: viewModel)
    
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        viewModel.updateSearchRepositories = self
        configureTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureTableView() {
        self.addSubview(tableView)
        tableView.delegate = mainTableViewDelegate
        tableView.dataSource = mainTableViewDataSource
        tableView.separatorStyle = .none
        tableView.register(MainCustomCell.self, forCellReuseIdentifier: Constants.mainCellReuseId)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}

extension MainView: ReloadMainTableViewDelegate {
    func reloadTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
