//
//  DetailTableViewDataSource.swift
//  CodeAddictTask
//
//  Created by Jakub Homik on 18/12/2020.
//

import UIKit

class DetailTableViewDataSource: NSObject, UITableViewDataSource {
    
    var viewModel: DetailViewModel
    
    init(viewModel: DetailViewModel) {
        self.viewModel = viewModel
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.listCommits.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.detailCellReuseId, for: indexPath) as? DetailCustomCell else { return UITableViewCell() }
        
        cell.listOfCommits = viewModel.listCommits[indexPath.row]
        cell.circleWithNumberView.numberOfCommit.text = "\(indexPath.row + 1)"
        
        return cell
    }
}
