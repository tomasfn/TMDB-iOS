//
//  MovieViewModel.swift
//  Movies
//
//  Created by Tomás Fernández Velazco on 04/06/2021.
//

import Foundation
import UIKit

protocol MovieCellView {
    func displayMovie(title: String, description: String, averageVote: String, posterImgUrl: String)
}

protocol MovieView: class {
    func startLoading()
    func finishLoading()
    func showMovieDetails(viewModel: DetailViewModel)
    func showError(error: String)
}

class MovieViewModel {
    
    var reloadTableViewClosure: (()->())?
    var updateLoadingStatusClosure: (()->())?
      
    let apiService: APIServiceProtocol
    
    var searchingName = String()
    
    private weak var view: MovieView?

    var movies: [Movie] = [Movie]() {
        didSet {
            self.reloadTableViewClosure?()
        }
    }
    
    func setView(view: MovieView) {
        self.view = view
    }
        
    var currentPage : Int = 0
    var totalPages : Int = 0
    
    var isLoading: Bool = false {
        didSet {
            self.updateLoadingStatusClosure?()
        }
    }

    init(apiService: APIServiceProtocol = NetworkService()) {
        self.apiService = apiService
    }
    
    func fetchData(name: String) {
    self.isLoading = true
        self.searchingName = name

        self.view?.startLoading()
        apiService.searchMovie(name: name, page: String(currentPage)) { [weak self] (movies, totalPages, error) in
            guard let self = self else { return }
            self.view?.finishLoading()
            
            if let error = error {
                self.view?.showError(error: error.localizedDescription)
            } else {
                guard let movies = movies else { return }
                guard let totalPages = totalPages else { return }
                
                if self.currentPage > 1 {
                    self.movies.append(contentsOf: movies)
                } else {
                    self.movies = movies
                }
                
                self.totalPages = totalPages
                self.isLoading = false
                self.view?.finishLoading()
            }
        }
  }
    
    func loadMoreItemsForList(){
        currentPage += 1
        fetchData(name: searchingName)
    }
  
    func configure(cell: MovieCellView, for index: Int) {
        let movie = movies[index]
        cell.displayMovie(title: movie.title, description: movie.overview, averageVote: String(movie.voteAverage), posterImgUrl: movie.posterPath ?? SharedInfo.placeHolderImgUrl)
    }
    
    func showDetails(index: Int) {
        let movie = movies[index]
        let detailViewModel = DetailViewModel(selectedMovie: movie)
        view?.showMovieDetails(viewModel: detailViewModel)
    }
        
    func getMoviesCount() -> Int {
        return movies.count
    }
        
}
