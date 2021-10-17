//
//  UIView.swift
//  Navigation
//
//  Created by a.agataev on 13.10.2021.
//

import Foundation
import UIKit

extension UIView {
    func toAutoLayout() {
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func addSubviews(_ views: [UIView]) {
        views.forEach{ addSubview($0) }
    }
    
}
