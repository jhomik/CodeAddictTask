//
//  DetailVC.swift
//  CodeAddictTask
//
//  Created by Jakub Homik on 09/12/2020.
//

import UIKit

class DetailVC: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    private(set) var activityIndicator = UIActivityIndicatorView()
    private(set) var containerView = UIView()
    private let detailView = DetailView()
    private let tableView = UITableView()
    private let detailShareRepoView = DetailShareRepoView()
    private let networkManager = NetworkManager()
    var repositoryTitle: Repositories?
    private(set) var detailRepositories: DetailRepositories? {
        didSet {
            updateUI()
        }
    }
    private(set) var listCommits: [ListCommit] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureDetailView()
        configureDetailShareRepoView()
        configureTableView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureDetailVC()
        downloadRepositories()
        downloadCommits()
    }
    
    private func downloadRepositories() {
        networkManager.getRepositories(forOwner: repositoryTitle?.owner.login ?? "", repoName: repositoryTitle?.name ?? "") { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let detailRepositories):
                print(detailRepositories)
                self.detailRepositories = detailRepositories
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func downloadCommits() {
        showLoadingSpinner(with: containerView, spinner: activityIndicator)
        networkManager.getListCommits(forOwner: repositoryTitle?.owner.login ?? "" , repoName: repositoryTitle?.name ?? "") { [weak self] (result) in
            guard let self = self else { return }
            self.dismissLoadingSpinner(with: self.containerView, spinner: self.activityIndicator)
            switch result {
            case .success(let commits):
                DispatchQueue.main.async {
                    self.listCommits = commits
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    private func shareRepository() {
        guard let detailRepo = detailRepositories, let url = URL(string: detailRepo.htmlUrl) else { return }
        let items: [Any] = [Constants.checkOutThisRepository + "\(detailRepo.name)", url]
        let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
        present(ac, animated: true)
    }
    
    private func updateUI() {
        detailView.detailRepositories = detailRepositories
    }
    
    private func configureDetailVC() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.view.backgroundColor = .clear
        view.backgroundColor = .systemBackground
        setNeedsStatusBarAppearanceUpdate()
    }
    
    private func configureDetailView() {
        view.addSubview(detailView)
        detailView.delegate = self
        
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
        detailShareRepoView.delegate = self
        
        NSLayoutConstraint.activate([
            detailShareRepoView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            detailShareRepoView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            detailShareRepoView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            detailShareRepoView.heightAnchor.constraint(equalToConstant: 94)
        ])
    }
}

extension DetailVC: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 120
//    }
}

extension DetailVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listCommits.count
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.detailCellReuseId, for: indexPath) as? DetailCustomCell else { return UITableViewCell() }
        cell.listOfCommits = listCommits[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 89
    }
}

extension DetailVC: ViewOnlineButtonDelegate {
    func buttonTapped() {
        guard let detailRepo = detailRepositories else { return }
        presentRepositoryOnSafari(with: detailRepo.htmlUrl)
    }
}

extension DetailVC: ShareRepoButtonDelegate {
    func share() {
        shareRepository()
    }
}
