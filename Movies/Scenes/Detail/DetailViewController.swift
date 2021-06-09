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
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: DetailViewModel!
    
    static func `init`(with viewModel: DetailViewModel) -> DetailViewController {
        let vc = NavigationHelper.detailViewController()
        vc.viewModel = viewModel
        return vc
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "\(String(describing: viewModel.selectedMovie!.title))"
        setUpTable()
        
        viewModel.setView(view: self)
        viewModel.setPoster()
    }
}

