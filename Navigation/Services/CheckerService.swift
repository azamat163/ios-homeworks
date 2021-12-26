//
//  CheckerService.swift
//  Navigation
//
//  Created by Азамат Агатаев on 26.12.2021.
//

import Foundation

protocol CheckerServiceProtocol {
    func checkLoginPasswordExists(loginText: String, passwordText: String) -> Bool
}

class CheckerService: CheckerServiceProtocol {
        
    static let shared = CheckerService()
    
    private let login = "Vasily"
    private let password = "StrongPassword"
    
    private init() {}
    
    func checkLoginPasswordExists(loginText: String, passwordText: String) -> Bool {
        guard login.hash == loginText.hash, password.hash == passwordText.hash else { return false }
        
        return true
    }
}
