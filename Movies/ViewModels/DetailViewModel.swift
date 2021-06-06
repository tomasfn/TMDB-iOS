//
//  DetailViewModel.swift
//  Movies
//
//  Created by Tomás Fernández Velazco on 06/06/2021.
//

import Foundation


protocol MovieDetailCellView {
    func displayInfo(info: String)
}

protocol MovieDetailView: class {
    func setMoviePoster(posterPath: String)
}

class DetailViewModel {
          
    var selectedMovie: Movie?
    
    private weak var view: MovieDetailView?
    
    func setView(view: MovieDetailView) {
        self.view = view
    }
    
    init(selectedMovie: Movie) {
        self.selectedMovie = selectedMovie
    }
    
    func getPopularityValue () -> String {
        var txt = ""
        if let popularity = selectedMovie?.popularity {
            txt = "Popularidad:" + " \(popularity)"
        }
        return txt
    }
    
    func getFullPosterPathUrl() -> String {
        var txt = ""
        if let posterImage = selectedMovie?.backDropPath {
            txt = SharedInfo.baseUrlForImage + posterImage
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
    
    func getSpokenLanguage() -> String {
        var txt = ""
        if let lang = selectedMovie?.originalLanguage {
            let name = languageName(countryCode: lang)
            txt = "Idioma original:" + " \(name)"
        }
        return txt
    }
    
    func getMovieDescription() -> String {
        var txt = ""
        if let description = selectedMovie?.overview {
            txt = "Sinopsis:" + " \(description)"
        }
        return txt
    }
    
    func getMovieTitle() -> String {
        var txt = ""
        if let title = selectedMovie?.title {
            txt = title
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
                
    func populateTableViewDetail() -> [String] {
        
        var values: [String] = [String]()
        
        values = [
            getMovieDescription(),
            getVoteAverage(),
            getSpokenLanguage(),
            getReleaseDate(),
            getPopularityValue(),
            getGenres()
        ]
        
        return values
    }
    
    func configure(cell: MovieDetailCellView, for index: Int) {
        let info = populateTableViewDetail()[index]
        cell.displayInfo(info: info)
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
    
    func setPoster() {
        view?.setMoviePoster(posterPath: self.getFullPosterPathUrl())
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

