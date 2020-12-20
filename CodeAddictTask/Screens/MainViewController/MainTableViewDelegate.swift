//
//  MainTableViewDelegate.swift
//  CodeAddictTask
//
//  Created by Jakub Homik on 17/12/2020.
//

import UIKit

class MainTableViewDelegate: NSObject, UITableViewDelegate {
    
    var viewModel = MainViewModel()
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        return viewModel.rowSelectedAt(indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 92
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 66
        default:
            return 9
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
