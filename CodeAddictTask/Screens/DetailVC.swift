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
    private let networkManager = NetworkManager()
    var repositoryTitle: Repositories?
    var detailRepositories: DetailRepositories?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureDetailView()
        configureDetailShareRepoView()
        configureTableView()
        
        networkManager.getRepositories(forOwner: repositoryTitle?.owner.login ?? "", repoName: repositoryTitle?.name ?? "") { (result) in
            switch result {
            case .success(let detailRepositories):
                self.detailRepositories = detailRepositories
                
                self.networkManager.getListCommits(forOwner: detailRepositories.owner.login , repoName: detailRepositories.name) { (result) in
                    switch result {
                    case .success(let commits):
                        print(commits)
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureDetailVC()
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
