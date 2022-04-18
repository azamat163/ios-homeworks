//
//  PlanetApi.swift
//  Navigation
//
//  Created by a.agataev on 18.04.2022.
//

import Foundation

struct PlanetApi {
    static var baseUrl: String {
        "https://swapi.dev/api/planets/1"
    }
    
    static var url: URLRequest {
        URLRequest(url: URL(string: baseUrl)!)
    }
}

extension PlanetApi {
    static func makeRequestPlanet(completion: @escaping (Result<PlanetModel, Error>) -> Void) {
        let task = URLSession.shared.dataTask(with: Self.url) { data, response, error in
            do {
                if let data = data {
                    let planetModel: PlanetModel = try JSONDecoder().decode(PlanetModel.self, from: data)
                    completion(.success(planetModel))
                }
                
            } catch {
                print("Failed to load: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    static func makeRequestPeople(urlPeople: String, completion: @escaping (Result<PlanetPeople, Error>) -> Void) {
        let task = URLSession.shared.dataTask(with: URLRequest(url: URL(string: urlPeople)!)) { data, response, error in
            do {
                if let data = data {
                    let planetPeople: PlanetPeople = try JSONDecoder().decode(PlanetPeople.self, from: data)
                    completion(.success(planetPeople))
                }
            } catch {
                print("Failed to load: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
}
