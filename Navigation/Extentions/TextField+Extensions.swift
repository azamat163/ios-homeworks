//
//  TextField+Extensions.swift
//  Navigation
//
//  Created by a.agataev on 22.10.2021.
//

import Foundation
import UIKit

extension UITextField {
    
    func roundedTextField(cornerRadius: CGFloat, borderWidth: CGFloat, borderColor: CGColor) {
        layer.cornerRadius = cornerRadius
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor
    }
    
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}
