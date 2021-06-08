//
//  MockAPIService.swift
//  Movies
//
//  Created by Tomás Fernández Velazco on 08/06/2021.
//

@testable import Movies

final class MockMovieService: APIServiceProtocol {
    var isSearchingMovieFromApi = false
    var completeClosure: (([Movie]?, Int?, Error?) -> ())!
    
    func searchMovie(name: String, page: String, completion: @escaping ([Movie]?, Int?, Error?) -> Void) {
        isSearchingMovieFromApi = true
        completeClosure = completion
    }
}

