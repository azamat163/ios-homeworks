//
//  LoginFactory.swift
//  Navigation
//
//  Created by Азамат Агатаев on 26.12.2021.
//

import Foundation

protocol LoginFactory {
    func makeLoginInspector() -> LoginInspector
}
