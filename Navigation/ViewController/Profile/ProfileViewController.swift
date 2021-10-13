//
//  ProfileViewController.swift
//  Navigation
//
//  Created by a.agataev on 11.10.2021.
//

import UIKit

class ProfileViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupProfile()
    }
    
    private func setupProfile() {
        if let profileView: ProfileView = .fromNib(){
            profileView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height)
            view.addSubview(profileView)
        }
    }
}
