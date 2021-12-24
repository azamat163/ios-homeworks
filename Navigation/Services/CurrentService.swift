//
//  File.swift
//  Navigation
//
//  Created by Азамат Агатаев on 24.12.2021.
//

import Foundation

class CurrentService: UserService {
    var user: User
    
    init(user: User) {
        self.user = user
    }

    func getUser(fullName: String) -> User? {
        guard user.fullName == fullName else { return nil }
        return user
    }
    
}
