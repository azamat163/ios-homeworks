//
//  UIImageView+Extensions.swift
//  Navigation
//
//  Created by a.agataev on 22.10.2021.
//

import Foundation
import UIKit

extension UIImageView {
    
    func roundedImage(cornerRadius: CGFloat, borderWidth: CGFloat, borderColor: CGColor) {
        layer.cornerRadius = cornerRadius
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor
    }
}
