//
//  HomeViewController.swift
//  Movies
//
//  Created by Tomás Fernández Velazco on 04/06/2021.
//

import UIKit
import Foundation
import Kingfisher

class HomeViewController: UISearchController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
            
    lazy var viewModel: MovieViewModel = {
          return MovieViewModel()
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        initViewModel()
        setUpCollectionView()
    }
    
    func initViewModel() {
        viewModel.reloadTableViewClosure = { [weak self] () in
           DispatchQueue.main.async {
              self?.collectionView.reloadData()
           }
        }
        viewModel.fetchData(name: "query")
    }
    
}

