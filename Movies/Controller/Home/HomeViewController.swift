//
//  HomeViewController.swift
//  Movies
//
//  Created by Tomás Fernández Velazco on 04/06/2021.
//

import UIKit
import Foundation

class HomeViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    let search = UISearchController(searchResultsController: nil)
    
    let spacing: Float = 16.0

    lazy var viewModel: MovieViewModel = {
          return MovieViewModel()
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Movies"
        
        initViewModel()
        setUpCollectionView()
        setUpSearchController()
    }
    
    func initViewModel() {
        viewModel.reloadTableViewClosure = { [weak self] () in
           DispatchQueue.main.async {
              self?.collectionView.reloadData()
           }
        }
        
        viewModel.setView(view: self)
    }
}


