//
//  TodosModel.swift
//  Navigation
//
//  Created by a.agataev on 18.04.2022.
//

struct TodosModel {
    let userId: Int
    let id: Int
    let title: String
    let completed: Bool
}

extension TodosModel {
    init?(json: [String: Any]) {
        guard let userId = json["userId"] as? Int,
              let id = json["id"] as? Int,
              let title = json["title"] as? String,
              let completed = json["completed"] as? Bool
        else { return nil }
        
        self.userId = userId
        self.id = id
        self.title = title
        self.completed = completed
    }
}
