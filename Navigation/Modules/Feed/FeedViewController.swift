//
//  FeedViewController.swift
//  Navigation
//
//  Created by a.agataev on 13.10.2021.
//

import UIKit

protocol FeedViewControllerDelegate: AnyObject {
    func clickButton()
    func changedText(notification: Notification) -> Void
}

final class FeedViewController: UIViewController {
    private var model: FeedModel
    
    init(model: FeedModel) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
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
        
        NotificationCenter.default.addObserver(self, selector: #selector(changedText), name: .changedText, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.post(name: .changedText, object: model)
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
    
    @objc
    func changedText(notification: Notification) -> Void  {
        guard let object = notification.object as? FeedModel else { return }
        // мне не нравится тут, что модель передаю во вью и не понимаю как сделать (
        feedView.model = object
    }
}

extension Notification.Name {
    static let changedText = Notification.Name("changedText")
}
