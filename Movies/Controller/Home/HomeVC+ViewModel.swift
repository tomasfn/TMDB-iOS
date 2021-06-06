//
//  HomeVC+ViewModel.swift
//  Movies
//
//  Created by Tomás Fernández Velazco on 06/06/2021.
//

import Foundation


extension HomeViewController: MovieView {
        
    func showMovieDetails(viewModel: DetailViewModel) {
        let vc = DetailViewController.`init`(with: viewModel)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func startLoading() {
        indicator.startAnimating()
        indicator.isHidden = false
    }
    
    func finishLoading() {
        indicator.stopAnimating()
        indicator.isHidden = true
    }

    func setEmpty() {

    }
    
    func showError(error: String) {
        print(error)
    }
    
}
