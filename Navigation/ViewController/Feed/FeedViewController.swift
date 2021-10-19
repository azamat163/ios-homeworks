//
//  FeedViewController.swift
//  Navigation
//
//  Created by a.agataev on 13.10.2021.
//

import UIKit

class FeedViewController: UIViewController {
    private enum Constains {
        static let postTitle: String = "Текст из экрана Feed"
    }
    
    lazy var feedView: FeedView = {
        feedView = FeedView(frame: CGRect(x: 0, y: 30, width: view.frame.size.width, height: view.frame.size.height - 30))
        feedView.postButton.addTarget(self, action: #selector(clickButton(_:)), for: .touchUpInside)
        return feedView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(feedView)
    }
    
    @objc func clickButton(_ sender: Any) {
        let post = Post(title: Constains.postTitle)
        let postVc: PostViewController = PostViewController()
        postVc.setupTitle(post)
        navigationController?.pushViewController(postVc, animated: true)
    }
}
