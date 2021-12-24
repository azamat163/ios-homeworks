//
//  TestUserService.swift
//  Navigation
//
//  Created by Азамат Агатаев on 24.12.2021.
//

import Foundation

class TestUserService: UserService {
    var user: User = User(fullName: "Test", avatar: "avatar_cat", status: "Busy Test")
    
    func getUser(fullName: String) -> User? {
        return user
    }
}
