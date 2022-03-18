//
//  User.swift
//  Navigation
//
//  Created by Азамат Агатаев on 24.12.2021.
//

import Foundation

class User {
    var fullName: String
    var avatar: String
    var status: String
    
    init(fullName: String, avatar: String, status: String) {
        self.fullName = fullName
        self.avatar = avatar
        self.status = status
    }
}
