//
//  HomeVC+CollectionView.swift
//  Movies
//
//  Created by Tomás Fernández Velazco on 06/06/2021.
//

import Foundation
import UIKit

//MARK: CollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func setUpCollectionView() {
        collectionView?.dataSource = self
        collectionView?.delegate = self
        collectionView?.register(UINib(nibName: BillboardCollectionViewCell.nameOfClass, bundle: nil), forCellWithReuseIdentifier: BillboardCollectionViewCell.nameOfClass)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getMoviesCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           return CGSize(width: 180, height: 180)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BillboardCollectionViewCell.nameOfClass, for: indexPath) as! BillboardCollectionViewCell
       
        viewModel.configure(cell: cell, for: indexPath.row)

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        viewModel.selectedMovie = viewModel.getDataMovieFromIndexPath(at: indexPath)
        
        let detailVc = NavigationHelper.detailViewController()
        detailVc.viewModel = viewModel
        detailVc.modalPresentationStyle = .formSheet
        present(detailVc, animated: true, completion: nil)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (((collectionView.contentOffset.y + collectionView.frame.size.height) > collectionView.contentSize.height ) && !viewModel.isLoading){
            viewModel.isLoading = true
            viewModel.loadMoreItemsForList()
        }
    }
}
