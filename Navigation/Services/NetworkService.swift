//
//  NetworkService.swift
//  Navigation
//
//  Created by a.agataev on 18.04.2022.
//

import Foundation

struct NetworkService {
    static func makeRequest(urlString: String) {
        guard let url = URL(string: urlString) else { return }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("error = \(error.localizedDescription)")
            }
            if let data = data {
                print("data =  \(String(describing: String(bytes: data, encoding: String.Encoding.utf8)))")
            }
            if let response = response as? HTTPURLResponse {
                print("allHeaderFields = \(response.allHeaderFields)")
                print("statuc code = \(response.statusCode)")
            }
        }
        
        task.resume()
    }
}

enum AppConfiguration: String, CaseIterable {
    static var allCases: [AppConfiguration] {
        return [.peoples, .films, .planets]
    }
    
    case peoples = "https://swapi.dev/api/people/8"
    case planets = "https://swapi.dev/api/planets/3"
    case films = "https://swapi.dev/api/films/"
}
