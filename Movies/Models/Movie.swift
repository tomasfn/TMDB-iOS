//
//  Movie.swift
//  Movies
//
//  Created by Tomás Fernández Velazco on 04/06/2021.
//

import Foundation

struct Movie: Codable {
    let poster_path: String
    let popularity: Double
    let id: Int
    let backdrop_path: String
    let vote_average: Double
    let overview: String
    let first_air_date: String
    let origin_country: [String]
    let genre_ids: [Int]
    let original_language: String
    let vote_count: Int
    let name: String
    let original_name: String
}

struct Result: Codable {
    let results: [Movie]
    let page: Int
}
