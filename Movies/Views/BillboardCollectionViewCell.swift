//
//  BillboardCollectionViewCell.swift
//  Movies
//
//  Created by Tomás Fernández Velazco on 04/06/2021.
//

import UIKit
import SDWebImage

class BillboardCollectionViewCell: UICollectionViewCell, MovieCellView {
    
    @IBOutlet weak var titleMovie: UILabel!
    @IBOutlet weak var movieDescription: UILabel!
    @IBOutlet weak var movieaverageVote: UILabel!
    @IBOutlet weak var posterMovieImage: ChachedImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func displayMovie(title: String, description: String, averageVote: String, posterImgUrl: String) {
        titleMovie.text = title
        movieDescription.text = description
        movieaverageVote.text = "Media de voto: \(averageVote)"
        posterMovieImage.sd_setImage(with: URL(string: SharedInfo.baseUrlForImage + posterImgUrl), placeholderImage: UIImage(named: "placeholder"))        
    }
}
