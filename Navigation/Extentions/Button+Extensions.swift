//
//  Button+Extensions.swift
//  Navigation
//
//  Created by a.agataev on 22.10.2021.
//

import Foundation
import UIKit

extension UIButton {
    
    func roundedButtonWithShadow(corderRadius: CGFloat, shadowOffset: CGSize, shadowRadius: CGFloat, shadowColor: CGColor, shadowOpacity: Float) {
        layer.cornerRadius = corderRadius
        layer.shadowColor = shadowColor
        layer.shadowOffset = shadowOffset
        layer.shadowOpacity = shadowOpacity
        layer.shadowRadius = shadowRadius
    }
}
