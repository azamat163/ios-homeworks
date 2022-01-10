//
//  MyLoginFactory.swift
//  Navigation
//
//  Created by Азамат Агатаев on 26.12.2021.
//

import Foundation

final class MyLoginFactory: LoginFactory {
    
    func makeLoginInspector() -> LoginInspector {
        return LoginInspector()
    }
}
