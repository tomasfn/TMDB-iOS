//
//  DetailTableViewCell.swift
//  Movies
//
//  Created by Tomás Fernández Velazco on 04/06/2021.
//

import UIKit
import Foundation

class DetailTableViewCell: UITableViewCell, MovieDetailCellView {

    @IBOutlet weak var infoLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func displayInfo(info: String) {
        infoLabel.text = info
    }
}
