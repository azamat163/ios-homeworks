//
//  PostViewController.swift
//  Navigation
//
//  Created by a.agataev on 14.10.2021.
//

import UIKit

class PostViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .green
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: .barItemTitle, style: .plain, target: self, action: #selector(goToInfo(sender:)))
    }
    
    func setupTitle(_ title: String) {
        self.title = title
    }
    
    @objc func goToInfo(sender: UIBarButtonItem) {
        let infoVc: InfoViewController = InfoViewController()
        present(infoVc, animated: true, completion: nil)
    }
}

private extension String {
    static let barItemTitle = "Info"
}
