//
//  LoginInspector.swift
//  Navigation
//
//  Created by Азамат Агатаев on 26.12.2021.
//

import Foundation

final class LoginInspector: LogInViewControllerCheckerDelegate {

    let sharedChecker = CheckerService.shared
    
    func checkLoginPasswordAvailability(inputLogin: String, inputPassword: String) -> Bool {
        sharedChecker.checkLoginPasswordExists(loginText: inputLogin, passwordText: inputPassword)
    }
}
