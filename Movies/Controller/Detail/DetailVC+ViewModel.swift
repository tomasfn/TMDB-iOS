//
//  DetailVC+ViewModel.swift
//  Movies
//
//  Created by Tomás Fernández Velazco on 06/06/2021.
//

import Foundation
import SDWebImage


extension DetailViewController: MovieDetailView {
    
    func setMoviePoster(posterPath: String) {
        backDropImage.sd_setImage(with: URL(string: posterPath), placeholderImage: UIImage(named: "placeholder"))
    }
}
