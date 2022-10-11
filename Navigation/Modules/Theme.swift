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
            lightMode: .black,
            darkMode: .white
        ),
        textLabel: .createColor(
            lightMode: .systemGray6,
            darkMode: .white
        ),
        buttonColor: .createColor(
            lightMode: .systemBlue,
            darkMode: .black
        ),
        background: .createColor(
            lightMode: .white,
            darkMode: .black
        )
    )
}
