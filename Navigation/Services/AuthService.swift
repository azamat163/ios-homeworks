//
//  AuthService.swift
//  Navigation
//
//  Created by a.agataev on 24.05.2022.
//

import Foundation

protocol AuthService {
    func login(email: String, password: String, completion: @escaping Handler)
    func createUser(email: String, password: String, completion: @escaping Handler)
    func signIn(email: String, password: String, completion: @escaping Handler)
    func signOut()
}
