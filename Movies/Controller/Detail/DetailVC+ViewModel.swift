//
//  DetailVC+ViewModel.swift
//  Movies
//
//  Created by Tomás Fernández Velazco on 06/06/2021.
//

import Foundation

extension DetailViewController: MovieDetailView {
    
    func setMoviewDetails() {
        overViewDescriptionLbl.text = viewModel.getMovieDescription()
    }
    
}


