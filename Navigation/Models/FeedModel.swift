//
//  FeedModel.swift
//  Navigation
//
//  Created by Азамат Агатаев on 23.01.2022.
//

import Foundation

struct FeedModel {
    var password: String = "пароль"
    
    func check(word: String) -> Bool? {
        guard password.lowercased() == word.lowercased() else { return false }
        
        return true
    }
}
