//
//  HomeVC+ViewModel.swift
//  Movies
//
//  Created by Tomás Fernández Velazco on 06/06/2021.
//

import Foundation

extension HomeViewController: MoviewView {
    
    func startLoading() {
        indicator.startAnimating()
        indicator.isHidden = false
    }
    
    func finishLoading() {
        indicator.stopAnimating()
        indicator.isHidden = true
    }
    
    func setMovies(movies: [Movie]) {
        collectionView.reloadData()
    }
    
    func setEmpty() {

    }
    
}
