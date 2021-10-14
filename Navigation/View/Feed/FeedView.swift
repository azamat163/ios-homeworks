//
//  FeedView.swift
//  Navigation
//
//  Created by a.agataev on 14.10.2021.
//

import UIKit

class FeedView: UIView {
    
    @IBOutlet weak var postButton: UIButton! {
        didSet {
            postButton.setTitle(.postButtonTitle, for: .normal)
        }
    }
}

private extension String {
    static let postButtonTitle = "Нажми и сделай пост!"
}
