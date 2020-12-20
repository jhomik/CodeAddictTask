//
//  MainTableViewDataSource.swift
//  CodeAddictTask
//
//  Created by Jakub Homik on 17/12/2020.
//

import UIKit

final class MainTableViewDataSource: NSObject, UITableViewDataSource {
    
    var viewModel: MainViewModel
    
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.filteredRepositories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.mainCellReuseId, for: indexPath) as? MainCustomCell else { return UITableViewCell() }
        
        viewModel.currentIndexPath(indexPath)
        cell.repositories = viewModel.filteredRepositories[indexPath.section]
        
        return cell
    }
}
