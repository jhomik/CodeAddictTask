//
//  SearchRepositoriesTableViewDelegate.swift
//  CodeAddictTask
//
//  Created by Jakub Homik on 17/12/2020.
//

import UIKit

final class SearchRepositoriesTableViewDelegate: NSObject, UITableViewDelegate {
    
    var viewModel: SearchRepositoriesViewModel
    
    init(viewModel: SearchRepositoriesViewModel) {
        self.viewModel = viewModel
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.rowSelectedAt(indexPath: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Margines.searchRepositoriesTableViewRowHeight
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return Margines.searchRepositoriesTableViewSectionHeightHeader
        default:
            return Margines.searchRepositoriesTableViewSectionDefaultHeight
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = RepositoryHeaderView()
        switch section {
        case 0:
            return headerView
        default:
            return UIView()
        }
    }
}
