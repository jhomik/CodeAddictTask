//
//  MainView.swift
//  CodeAddictTask
//
//  Created by Jakub Homik on 19/12/2020.
//

import UIKit

class MainView: UIView {

    private let tableView = UITableView()
    private let viewModel: MainViewModel
    private let mainTableViewDataSource = MainTableViewDataSource()
    private let mainTableViewDelegate = MainTableViewDelegate()
    
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        mainTableViewDataSource.viewModel = viewModel
        mainTableViewDelegate.viewModel = viewModel
        viewModel.updateRepositories = self
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
