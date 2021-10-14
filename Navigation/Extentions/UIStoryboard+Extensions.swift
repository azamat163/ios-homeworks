//
//  UIStoryboard+Extensions.swift
//  Navigation
//
//  Created by a.agataev on 14.10.2021.
//

import Foundation
import UIKit

protocol StoryboardIdentifiable {
    static var storyboardIdentifier: String { get }
}

extension StoryboardIdentifiable where Self: UIViewController {
    static var storyboardIdentifier: String {
        return String(describing: self)
    }
}

extension UIStoryboard {
    enum StoryBoard: String {
        case home
        case feed
        case post
        case info
        case profile
        
        var filename: String {
            return rawValue.capitalized
        }
    }
    
    convenience init(storyboard: StoryBoard, bundle: Bundle? = nil) {
        self.init(name: storyboard.filename, bundle: bundle)
    }
    
    func instantiateViewController<T: UIViewController>() -> T where T: StoryboardIdentifiable {
            
            guard let vc = self.instantiateViewController(withIdentifier: T.storyboardIdentifier) as? T else {
                fatalError("Couldn't instantiate view controller with identifier \(T.storyboardIdentifier) ")
            }
            
            return vc
        }
}
