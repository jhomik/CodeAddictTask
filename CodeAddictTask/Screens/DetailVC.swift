//
//  DetailVC.swift
//  CodeAddictTask
//
//  Created by Jakub Homik on 09/12/2020.
//

import UIKit

class DetailVC: UIViewController {
    
    private let detailView = DetailView()
    private let tableView = UITableView()
    private let detailShareRepoView = DetailShareRepoView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureDetailVC()
        configureDetailView()
        configureDetailShareRepoView()
        configureTableView()
    }
    
    private func configureDetailVC() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.view.backgroundColor = .clear
        view.backgroundColor = .systemBackground
    }
    
    private func configureDetailView() {
        view.addSubview(detailView)
        
        NSLayoutConstraint.activate([
            detailView.topAnchor.constraint(equalTo: view.topAnchor),
            detailView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            detailView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            detailView.heightAnchor.constraint(equalToConstant: 383)
        ])
    }
    
    private func configureTableView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(DetailCustomCell.self, forCellReuseIdentifier: Constants.detailCellReuseId)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 1))
        tableView.isScrollEnabled = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: detailView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: detailShareRepoView.topAnchor, constant: -24)
        ])
    }
    
    private func configureDetailShareRepoView() {
        view.addSubview(detailShareRepoView)
        
        NSLayoutConstraint.activate([
            detailShareRepoView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            detailShareRepoView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            detailShareRepoView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            detailShareRepoView.heightAnchor.constraint(equalToConstant: 94)
        ])
    }
}

extension DetailVC: UITableViewDelegate {
    
}

extension DetailVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.detailCellReuseId, for: indexPath) as? DetailCustomCell else { return UITableViewCell() }
        cell.updateCell()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 89
    }
}
