//
//  MovieViewModelTests.swift
//  MoviesTests
//
//  Created by Tomás Fernández Velazco on 08/06/2021.
//

import XCTest
@testable import Movies

class MovieViewModelTests: XCTestCase {
    
    var movieViewModel: MovieViewModel!
    var mockMoviesService: MockMovieService!

    override func setUp() {
        super.setUp()

        mockMoviesService = MockMovieService()
        movieViewModel = .init(apiService: mockMoviesService)
    }
    
    override func tearDown() {
        movieViewModel = nil
        mockMoviesService = nil
        
        super.tearDown()
    }
    
    func test_moviesRecievedWithSuccess() {
        movieViewModel.fetchData(name: "toy story")
        
        XCTAssertNotNil(movieViewModel.movies)
    }
    
    func test_moviesFailureRecieve() {
        movieViewModel.fetchData(name: "")
        
        XCTAssertEqual(movieViewModel.movies, [])
    }

}
