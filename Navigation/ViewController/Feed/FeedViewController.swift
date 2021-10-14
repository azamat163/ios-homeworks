//
//  FeedViewController.swift
//  Navigation
//
//  Created by a.agataev on 13.10.2021.
//

import UIKit

class FeedViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupFeed()
    }
    
    private func setupFeed() {
        if let feedView: FeedView = .fromNib() {
            feedView.frame = CGRect(x: 0, y: 30, width: view.frame.size.width, height: view.frame.size.height - 30)
            feedView.postButton.addTarget(self, action: #selector(clickButton(_:)), for: .touchUpInside)
            view.addSubview(feedView)
        }
    }
    
    @objc func clickButton(_ sender: Any) {
        let post = Post(title: "Текст из экрана Feed")
        let postStoryboard = UIStoryboard(storyboard: .post)
        let postVc: PostViewController = postStoryboard.instantiateViewController()
        postVc.setupTitle(post)
        let nc = UINavigationController(rootViewController: postVc)
        nc.modalPresentationStyle = .fullScreen
        present(nc, animated: true, completion: nil)
    }
}
