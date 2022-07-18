//
//  PostViewController.swift
//  Navigation
//
//  Created by a.agataev on 14.10.2021.
//

import UIKit

final class PostViewController: UIViewController {
    
    var postTitle: String
    var showInfoVc: ((UIViewController) -> Void)?
    
    init(postTitle: String) {
        self.postTitle = postTitle
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = postTitle
        view.backgroundColor = .green
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: .barItemTitle, style: .plain, target: self, action: #selector(goToInfo(sender:)))
    }
    
    @objc func goToInfo(sender: UIBarButtonItem) {
        showInfoVc?(self)
    }
}

private extension String {
    static let barItemTitle = String(localized: "post.barItem.title")
}
