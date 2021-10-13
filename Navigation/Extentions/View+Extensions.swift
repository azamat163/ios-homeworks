//
//  UIView.swift
//  Navigation
//
//  Created by a.agataev on 13.10.2021.
//

import Foundation
import UIKit

extension UIView {
    class func fromNib<T: UIView>() -> T? {
        let name = String(describing: T.self)
        guard
            let nib = Bundle.main.loadNibNamed(name, owner: self, options: nil)
            else { fatalError("missing expected nib named \(name)") }
        guard
            let view = nib.first as? T
            else { fatalError("view of type \(T.self) not found in \(nib)") }
        return view
    }
}
