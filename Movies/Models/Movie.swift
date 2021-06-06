//
//  Movie.swift
//  Movies
//
//  Created by Tomás Fernández Velazco on 04/06/2021.
//

import Foundation

struct Movie: Codable {
    let adult: Bool
    let posterPath: String?
    let popularity: Double
    let id: Int
    let backDropPath: String?
    let voteAverage: Double
    let overview: String
    let releaseDate: String
    let genresIds: [Int]
    let originalLanguage: String
    let voteCount: Int
    let video: Bool
    let title: String
    let originalTitle: String
}

extension Movie {
    enum CodingKeys: String, CodingKey {
        case adult
        case posterPath = "poster_path"
        case popularity
        case id
        case backDropPath = "backdrop_path"
        case voteAverage = "vote_average"
        case overview
        case releaseDate = "release_date"
        case genresIds = "genre_ids"
        case originalLanguage = "original_language"
        case voteCount = "vote_count"
        case video
        case title
        case originalTitle = "original_title"
    }
}

struct Result: Codable {
    let results: [Movie]
    let page: Int
}
