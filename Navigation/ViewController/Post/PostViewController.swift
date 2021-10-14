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
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(goToHome(_:)))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Info", style: .plain, target: self, action: #selector(goToInfo(sender:)))
    }
    
    func setupTitle(_ post: Post) {
        self.title = post.title
    }
    
    @objc func goToInfo(sender: UIBarButtonItem) {
        let infoStoryboard = UIStoryboard(storyboard: .info)
        let infoVc: InfoViewController = infoStoryboard.instantiateViewController()
        present(infoVc, animated: true, completion: nil)
    }
    
    @objc func goToHome(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
