//
//  ProfileViewController.swift
//  Navigation
//
//  Created by a.agataev on 11.10.2021.
//

import UIKit

class ProfileViewController: UIViewController {
    
    var profileView: ProfileView!
    
    override func loadView() {
        super.loadView()
        setupProfile()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func setupProfile() {
        profileView = ProfileView(frame: CGRect(x: 0, y: 150, width: view.frame.size.width, height: view.frame.size.height - 150))
        view.addSubview(profileView)
    }
}
