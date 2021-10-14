//
//  InfoView.swift
//  Navigation
//
//  Created by a.agataev on 14.10.2021.
//

import UIKit

class InfoView: UIView {

    @IBOutlet weak var alertButton: UIButton! {
        didSet {
            alertButton.setTitle(.alertButtonTitle, for: .normal)
        }
    }
}

private extension String {
    static let alertButtonTitle = "Кнопка для вызова алерта"
}
