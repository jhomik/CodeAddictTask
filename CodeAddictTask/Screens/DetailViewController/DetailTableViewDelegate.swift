//
//  DetailTableViewDelegate.swift
//  CodeAddictTask
//
//  Created by Jakub Homik on 18/12/2020.
//

import UIKit

class DetailTableViewDelegate: NSObject, UITableViewDelegate {
    
    var viewModel: DetailViewModel
    
    init(viewModel: DetailViewModel) {
        self.viewModel = viewModel
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
