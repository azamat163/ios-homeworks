//
//  UserService.swift
//  Navigation
//
//  Created by Азамат Агатаев on 24.12.2021.
//

import Foundation

protocol UserService {
    func getUser(fullName: String) throws -> User
}
