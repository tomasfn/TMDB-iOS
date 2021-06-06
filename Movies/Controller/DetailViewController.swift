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
        setUpTable()
        setElements()
    }
    
    func setUpTable() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: DetailTableViewCell.nameOfClass, bundle: nil), forCellReuseIdentifier: DetailTableViewCell.nameOfClass)
    }
    
    func setElements() {
        overViewDescriptionLbl.text = viewModel.getMovieDescription()
        backDropImage.loadImage(urlStr: viewModel.getFullBackdropPathUrl())
    }
}


//MARK: TableViewDelegate
extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.populateTableViewDetail().count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DetailTableViewCell.nameOfClass, for: indexPath) as! DetailTableViewCell
        
        cell.infoLabel.text = viewModel.populateTableViewDetail()[indexPath.row]
        return cell
    }
}
