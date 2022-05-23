//
//  TodosApi.swift
//  Navigation
//
//  Created by a.agataev on 18.04.2022.
//

import Foundation

struct TodosApi {
    static var baseUrl: String {
        "https://jsonplaceholder.typicode.com/todos/23"
    }
    
    static var url: URLRequest {
        URLRequest(url: URL(string: baseUrl)!)
    }
}

extension TodosApi {
    static func makeRequest(completion: @escaping (Result<TodosModel?, Error>) -> Void) {
        let task = URLSession.shared.dataTask(with: Self.url) { data, response, error in
            do {
                if let data = data,
                   let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    let todosModel = TodosModel(json: json)
                    completion(.success(todosModel))
                }
                
            } catch {
                print("Failed to load: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
}
