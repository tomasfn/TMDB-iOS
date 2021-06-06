//
//  BaseService.swift
//  Movies
//
//  Created by Tomás Fernández Velazco on 06/06/2021.
//

import Foundation
import Moya

enum BaseService {
    case searchMovie(name: String)
}

extension BaseService: TargetType {
        
    var baseURL: URL {
        return URL(string: "https://api.themoviedb.org/3/")!
    }
    
    var path: String {
        switch self {
        case .searchMovie:
            return "/search/movie"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        //For unit testing
        return Data()
    }
    
    var task: Task {
        switch self {
        case .searchMovie(let name):
            return .requestParameters(parameters: [ "api_key": SharedInfo.apiKey, "query": name], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        return [
            "Accept" : "application/json",
            "Content-Type" : "application/json"
        ]
    }
}
