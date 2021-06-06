//
//  DetailVC+TableView.swift
//  Movies
//
//  Created by Tomás Fernández Velazco on 06/06/2021.
//

import UIKit

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func setUpTable() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: DetailTableViewCell.nameOfClass, bundle: nil), forCellReuseIdentifier: DetailTableViewCell.nameOfClass)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.populateTableViewDetail().count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DetailTableViewCell.nameOfClass, for: indexPath) as! DetailTableViewCell
        
        cell.infoLabel.text = viewModel.populateTableViewDetail()[indexPath.row]
        return cell
    }
}
