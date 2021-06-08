//
//  HomeVC+SearchController.swift
//  Movies
//
//  Created by Tomás Fernández Velazco on 06/06/2021.
//

import UIKit

extension HomeViewController: UISearchControllerDelegate, UISearchResultsUpdating {
    
    func setUpSearchController() {
        search.searchResultsUpdater = self
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.placeholder = "Type something here to search"
        navigationItem.searchController = search
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        print(text)
        
        viewModel.movies.removeAll()
        viewModel.currentPage = 1
        
        viewModel.fetchData(name: text)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("touches cancel")
    }
}
