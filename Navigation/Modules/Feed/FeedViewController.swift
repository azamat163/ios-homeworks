//
//  FeedViewController.swift
//  Navigation
//
//  Created by a.agataev on 13.10.2021.
//

import UIKit

protocol FeedViewControllerDelegate: AnyObject {
    func clickButton()
    func clickCheckerButton(word: String)
}

final class FeedViewController: UIViewController {
    private var model: FeedModel
    
    init(model: FeedModel) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var feedView: FeedView = {
        feedView = FeedView(frame: .zero)

        return feedView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(feedView)
        
        feedView.toAutoLayout()
        setupLayout()
        
        feedView.delegate = self
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            feedView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            feedView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            feedView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            feedView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}


private extension String {
    static let postTitle: String = "Текст из экрана Feed"
}

extension FeedViewController: FeedViewControllerDelegate {
    func clickButton() {
        let postVc: PostViewController = PostViewController()
        postVc.setupTitle(.postTitle)
        navigationController?.pushViewController(postVc, animated: true)
    }
    
    func clickCheckerButton(word: String) {
        model.check(word: word)
    }
}
