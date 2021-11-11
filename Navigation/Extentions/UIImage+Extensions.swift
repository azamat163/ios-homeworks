//
//  UIImage+Extensions.swift
//  Navigation
//
//  Created by Азамат Агатаев on 05.11.2021.
//

import Foundation
import UIKit

extension UIImage {
    
    func alpha(_ value: CGFloat) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(at: CGPoint.zero, blendMode: .normal, alpha: value)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
}
