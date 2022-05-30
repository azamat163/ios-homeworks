//
//  LoginService.swift
//  Navigation
//
//  Created by a.agataev on 24.05.2022.
//

import Foundation

enum LoginService {
    case firebase
    case realm
    
    var current: AuthService {
        switch self {
        case .firebase:
            return FirebaseService()
        case .realm:
            return RealmService()
        }
    }
}
