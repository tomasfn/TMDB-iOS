//
//  MovieViewModel.swift
//  Movies
//
//  Created by Tomás Fernández Velazco on 04/06/2021.
//

import Foundation
import UIKit
import Kingfisher

protocol MovieCellView {
    func displayMovie(title: String, description: String, averageVote: String, posterImgUrl: String)
}

protocol MovieView: class {
    func startLoading()
    func finishLoading()
    func setMovies(movies: [Movie])
    func setEmpty()
    func showError(error: String)
}

class MovieViewModel {
    
    var reloadTableViewClosure: (()->())?
    var updateLoadingStatusClosure: (()->())?
      
    let apiService: APIServiceProtocol
    var selectedMovie: Movie?
    
    private weak var view: MovieView?

    var movies: [Movie] = [Movie]() {
        didSet {
            self.reloadTableViewClosure?()
        }
    }
        
    var currentPage : Int = 1
    var currentLanguage : String = CountryLanguage.es.rawValue

    var isLoading: Bool = false {
        didSet {
            self.updateLoadingStatusClosure?()
        }
    }

    init(apiService: APIServiceProtocol = NetworkService()) {
        self.apiService = apiService
    }
    
    func fetchData(name: String?) {
    self.isLoading = true
        
        apiService.searchMovie(name: name ?? "", page: String(currentPage)) { [weak self] (movies, error) in
            guard let self = self else { return }
            self.view?.finishLoading()
            
            if let error = error {
                self.view?.showError(error: error.localizedDescription)
            } else {
                guard let movies = movies else { return }
                self.movies = movies
                self.view?.finishLoading()
            }
        }
  }
    
    func loadMoreItemsForList(){
        currentPage += 1
        fetchData(name: nil)
    }
      
    func getDataMovieFromIndexPath( at indexPath: IndexPath ) -> Movie {
        return movies[indexPath.row]
    }
    
    func getPopularityValue () -> String {
        var txt = ""
        if let popularity = selectedMovie?.popularity {
            txt = "Popularidad:" + " \(popularity)"
        }
        return txt
    }
    
    func getVoteAverage() -> String {
        var txt = ""
        if let average = selectedMovie?.voteAverage {
            txt = "Votacion promedio:" + " \(average)"
        }
        return txt
    }
        
    func getReleaseDate() -> String {
        
        var formattedFinalDate = ""
        
        if let date = selectedMovie?.releaseDate {
            if let dat = formattedDate(date: date) {
                formattedFinalDate = finalDate(date: dat)!
            }
        }
        
        return "Fecha de estreno:" + " \(formattedFinalDate)"
    }
    
//    func getFullBackdropPathUrl() -> String {
//        var txt = ""
//        if let backdrop = selectedMovie?.backDropPath {
//            txt = SharedInfo.baseUrlForImage + backdrop
//        }
//        return txt
//    }
//
//    func getFullPosterPathUrl(at indexPath: IndexPath) -> String {
//        var txt = ""
//        txt = SharedInfo.baseUrlForImage + movies[indexPath.row].posterPath
//        return txt
//    }
    
    func getSpokenLanguage() -> String {
        var txt = ""
        if let lang = selectedMovie?.originalLanguage {
            let name = languageName(countryCode: lang)
            txt = "Idioma original:" + " \(name)"
        }
        return txt
    }
    
    func getGenres() -> String {
        var txt = ""
        if let ids = selectedMovie?.genresIds {
            
            var countries = [String]()
            for id in ids {
                countries.append(String(id))
            }
            
            txt = "Género:" + " \(countries.joined(separator: ", "))"
        }
        return txt
    }
    
    func getMovieDescription() -> String {
        var txt = ""
        if let sinposis = selectedMovie?.overview {
            txt = sinposis
        }
        return txt
    }
        
    func configure(cell: MovieCellView, for index: Int) {
        let movie = movies[index]
        cell.displayMovie(title: movie.title, description: movie.overview, averageVote: String(movie.voteAverage), posterImgUrl: movie.posterPath ?? "https://i.blogs.es/594843/chrome/450_1000.jpg")
    }
    
    func getMoviesCount() -> Int {
        return movies.count
    }
    
    func populateTableViewDetail() -> [String] {
        
        var values: [String] = [String]()
        
        values = [
            getPopularityValue(),
            getSpokenLanguage(),
            getReleaseDate(),
            getVoteAverage(),
            getGenres()
        ]
        
        return values
    }
    
    func formattedDate(date: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: date)
        return date
    }
    
    func finalDate(date: Date) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy"
        let str = dateFormatter.string(from: date)
        return str
    }
    
    func countryCode(from countryName: String) -> String? {
        return NSLocale.isoCountryCodes.first { (code) -> Bool in
            let name = NSLocale.current.localizedString(forRegionCode: code)
            return name == countryName
        }
    }
    
    func languageName(countryCode: String) -> String {
        switch countryCode {
        case CountryLanguage.en.rawValue:
            return "Inglés"
        case CountryLanguage.es.rawValue:
            return "Español"
        case CountryLanguage.ja.rawValue:
            return "Japonés"
        case CountryLanguage.fr.rawValue:
            return "Francés"
        default:
            return countryCode
        }
    }
}
