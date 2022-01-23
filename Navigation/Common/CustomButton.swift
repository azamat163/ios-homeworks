//
//  CustomButton.swift
//  Navigation
//
//  Created by Азамат Агатаев on 23.01.2022.
//

import Foundation
import UIKit

final class CustomButton: UIButton {
    var onTap: (() -> Void)?
    
    func apply(title: String, titleColor: UIColor) {
        setTitle(title, for: .normal)
        setTitleColor(titleColor, for: .normal)
        addTarget(self, action: #selector(handleButtonTapped), for: .touchUpInside)
    }
    
    @objc
    private func handleButtonTapped() {
        onTap?()
    }
    
}
