//
//  NetworkServices.swift
//  Movies
//
//  Created by Tomás Fernández Velazco on 04/06/2021.
//

import Foundation
import Moya


protocol APIServiceProtocol: AnyObject {
    func searchMovie(name: String, page: String, completion: @escaping ([Movie]?, Error?)->Void)
}

class NetworkService: APIServiceProtocol {
    
    let baseProvider = MoyaProvider<BaseService>()

    func searchMovie(name: String, page: String, completion: @escaping ([Movie]?, Error?) -> Void) {
        
        baseProvider.request(.searchMovie(name: name)) { (result) in
            switch result {
            case let .success(response):
                            
                do {
                     let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .useDefaultKeys
                    let result = try decoder.decode(Result.self, from: response.data)
                    let movies = result.results
                    completion(movies, nil)
                    
                } catch let error {
                    // Status code error or Mapping Error
                    print(error)
                    completion(nil, error)
                }
     
            case let .failure(error):
                print(error.localizedDescription)
                completion(nil, error)
            }
        }
    }
}
