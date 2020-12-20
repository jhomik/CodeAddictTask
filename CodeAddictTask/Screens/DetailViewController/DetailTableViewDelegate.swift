//
//  DetailTableViewDelegate.swift
//  CodeAddictTask
//
//  Created by Jakub Homik on 18/12/2020.
//

import UIKit

class DetailTableViewDelegate: NSObject, UITableViewDelegate {
    
    var viewModel = DetailViewModel()
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
