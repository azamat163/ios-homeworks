//
//  FeedViewController.swift
//  Navigation
//
//  Created by a.agataev on 13.10.2021.
//

import UIKit

class FeedViewController: UIViewController {
    
    lazy var feedView: FeedView = {
        feedView = FeedView(frame: .zero)
        feedView.firstPostButton.addTarget(self, action: #selector(clickButton), for: .touchUpInside)
        feedView.secondPostButton.addTarget(self, action: #selector(clickButton), for: .touchUpInside)
        return feedView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(feedView)
        
        feedView.toAutoLayout()
        setupLayout()
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            feedView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            feedView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            feedView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            feedView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    @objc func clickButton() {
        let post = Post(title: .postTitle)
        let postVc: PostViewController = PostViewController()
        postVc.setupTitle(post)
        navigationController?.pushViewController(postVc, animated: true)
    }
}

private extension String {
    static let postTitle: String = "Текст из экрана Feed"
}
