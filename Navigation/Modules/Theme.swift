//
//  Theme.swift
//  Navigation
//
//  Created by a.agataev on 16.07.2022.
//

import Foundation
import UIKit

protocol ThemeAble {
    func apply(theme: Theme)
}

struct Theme {
    let titleLabel: UIColor
    let textLabel: UIColor
    let buttonColor: UIColor
    let background: UIColor
}

extension Theme {
    static let current = Self(
        titleLabel: .createColor(
            lightMode: .lightGray,
            darkMode: .white
        ),
        textLabel: .createColor(
            lightMode: .lightGray,
            darkMode: .white
        ),
        buttonColor: .createColor(
            lightMode: .green,
            darkMode: .black
        ),
        background: .createColor(
            lightMode: .purple,
            darkMode: .black
        )
    )
}
