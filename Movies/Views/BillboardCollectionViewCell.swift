//
//  BillboardCollectionViewCell.swift
//  Movies
//
//  Created by Tomás Fernández Velazco on 04/06/2021.
//

import UIKit
import Kingfisher

class BillboardCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var titleMovie: UILabel!
    @IBOutlet weak var posterMovieImage: ChachedImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureWithMovie(movie: Movie) {
        titleMovie.text = movie.original_name
    }
}
