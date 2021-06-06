//
//  Commons.swift
//  Movies
//
//  Created by Tomás Fernández Velazco on 04/06/2021.
//

import Foundation
import UIKit

extension NSObject {
    public class var nameOfClass: String {
        return String(describing: self).components(separatedBy: ".").last!
    }
}

extension UIImageView {
    func dowloadFromServer(url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        contentMode = mode
        
        let parameters: [String: String] = [
            "api_key" : SharedInfo.apiKey
        ]
        
        let headers: [String: String] = [
            "Content-Type":"application/json",
            "Accept":"application/json"
        ]
        
        var urlComp = URLComponents(string: url.absoluteString)
        
        var queryItems = [URLQueryItem]()
        for (key, value) in parameters {
            queryItems.append(URLQueryItem(name: key, value: value))
        }

        urlComp?.queryItems = queryItems
        
        var request = URLRequest(url: (urlComp?.url!)!)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
                        
        URLSession.shared.dataTask(with: request as URLRequest) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
            }.resume()
    }
    func dowloadFromServer(link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        dowloadFromServer(url: url, contentMode: mode)
    }
}

