//
//  DetailViewController.swift
//  Movies
//
//  Created by Tomás Fernández Velazco on 04/06/2021.
//

import UIKit
import Foundation

class DetailViewController: UIViewController {
    
    @IBOutlet weak var backDropImage: ChachedImageView!
    @IBOutlet weak var overViewDescriptionLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel = MovieViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "\(String(describing: viewModel.selectedMovie?.title))"
        setUpTable()
    }
}

