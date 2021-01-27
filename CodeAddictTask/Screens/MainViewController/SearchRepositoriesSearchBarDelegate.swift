//
//  SearchRepositoriesSearchBarDelegate.swift
//  CodeAddictTask
//
//  Created by Jakub Homik on 17/12/2020.
//

import UIKit

final class SearchRepositoriesSearchBarDelegate: NSObject, UISearchBarDelegate {
    
    var viewModel: SearchRepositoriesViewModel
    
    init(viewModel: SearchRepositoriesViewModel) {
        self.viewModel = viewModel
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(reload), object: searchBar)
        perform(#selector(reload), with: searchBar, afterDelay: 0.2)
    }
    
    @objc func reload(_ searchBar: UISearchBar) {
        viewModel.checkSearchBar(searchBar.text)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.cancelButtonTapped()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.updateSearchWord(searchBar.text)
    }
}
