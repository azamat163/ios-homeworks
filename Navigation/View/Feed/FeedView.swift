//
//  FeedView.swift
//  Navigation
//
//  Created by a.agataev on 14.10.2021.
//

import UIKit

class FeedView: UIView {
    private enum Constains {
        static let width: CGFloat = 200
        static let height: CGFloat = 60
        static let bordetWidth: CGFloat = 1.0
        static let borderColor: CGColor = UIColor.blue.cgColor
    }
    
    lazy var postButton: UIButton = {
        postButton = UIButton(frame: .zero)
        postButton.setTitle(.postButtonTitle, for: .normal)
        postButton.setTitleColor(.blue, for: .normal)
        postButton.layer.borderColor = Constains.borderColor
        postButton.layer.borderWidth = Constains.bordetWidth
        return postButton
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(postButton)
        
        postButton.toAutoLayout()
        setupButtonLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupButtonLayout() {
        NSLayoutConstraint.activate([
            postButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            postButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            postButton.widthAnchor.constraint(equalToConstant: Constains.width),
            postButton.heightAnchor.constraint(equalToConstant: Constains.height)
        ])
    }
}

private extension String {
    static let postButtonTitle = "Нажми и сделай пост!"
}
