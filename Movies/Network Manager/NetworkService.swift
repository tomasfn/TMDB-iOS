//
//  NetworkServices.swift
//  Movies
//
//  Created by Tomás Fernández Velazco on 04/06/2021.
//

import Foundation

typealias gettingMoviesBlock = ([Movie]?, Error?) -> Void
typealias moviesBlock = ([Movie]?) -> Void

protocol APIServiceProtocol: AnyObject {
    func getMovies(page: String, language: String, complete: @escaping ( _ success: Bool, _ movies: [Movie]?, _ error: Error? )->() )
}

class NetworkServices: APIServiceProtocol {

    func getMovies(page: String, language: String, complete: @escaping (Bool, [Movie]?, Error?) -> ()) {
        
        let headers: [String: String] = [
            "Content-Type":"application/json",
            "Accept":"application/json"
        ]
        
        let parameters: [String: String] = [
            "api_key" : SharedInfo.apiKey,
            "page" : page,
            "language" : language
        ]
        
        var urlComp = URLComponents(string: SharedInfo.baseUrl + SharedInfo.popular)
        
        var queryItems = [URLQueryItem]()
        for (key, value) in parameters {
            queryItems.append(URLQueryItem(name: key, value: value))
        }

        urlComp?.queryItems = queryItems
                
        let session = URLSession.shared
        var request = URLRequest(url: (urlComp?.url!)!)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
                
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            guard error == nil else {
                complete(true, nil, error)
                return
            }
            guard let data = data else {
                return
            }
            do {
                 let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .useDefaultKeys
                let response = try decoder.decode(Result.self, from: data)
                let movies = response.results
                complete(true, movies, nil )
            } catch {
                print(error)
                complete(true, nil, error )
            }
        })
        task.resume()
    }
}
