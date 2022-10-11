//
//  LoginInspector.swift
//  Navigation
//
//  Created by Азамат Агатаев on 26.12.2021.
//

import Foundation
import FirebaseAuth

final class LoginInspector: LogInViewControllerCheckerDelegate {
    private var loginService: LoginService = .firebase
    
    func login(inputLogin: String, inputPassword: String, completion: @escaping Handler) {
        loginService.current.login(email: inputLogin, password: inputPassword, completion: completion)
    }
    
    func signOut() {
        loginService.current.signOut()
    }
}
