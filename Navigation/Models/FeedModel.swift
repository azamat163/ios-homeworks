//
//  FeedModel.swift
//  Navigation
//
//  Created by Азамат Агатаев on 23.01.2022.
//

import Foundation

class FeedModel {
    var password: String
    
    init(password: String = "пароль") {
        self.password = password
    }
    
    func check(word: String) {
        NotificationCenter.default.post(name: .checkPassword, object: password.lowercased() == word.lowercased())
    }
}

extension Notification.Name {
    static let checkPassword = Notification.Name("checkPassword")
}
