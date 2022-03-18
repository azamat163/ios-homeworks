//
//  File.swift
//  Navigation
//
//  Created by Азамат Агатаев on 24.12.2021.
//

import Foundation

enum UserNotFoundError: Error {
    case userNotFound
}

extension UserNotFoundError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .userNotFound:
            return "Пользователь не найден"
        }
    }
}

class CurrentService: UserService {
    var user: User
    
    init(user: User) {
        self.user = user
    }

    func getUser(fullName: String) throws -> User {
        guard user.fullName == fullName else { throw UserNotFoundError.userNotFound }
        return user
    }
    
}
