//
//  ProfileView.swift
//  Navigation
//
//  Created by a.agataev on 11.10.2021.
//

import UIKit

class ProfileView: UIView {
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var profileNameLabel: UILabel!
    
    @IBOutlet weak var profileBirthdayLabel: UILabel!
    
    @IBOutlet weak var profileCityLabel: UILabel!
    
    @IBOutlet weak var profileIdentifierTextView: UITextView!
}

extension UIView {
    class func fromNib<T: UIView>() -> T {
        return Bundle(for: T.self).loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
}
