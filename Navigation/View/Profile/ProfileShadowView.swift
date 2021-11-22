//
//  ProfileShadowView.swift
//  Navigation
//
//  Created by Азамат Агатаев on 21.11.2021.
//

import UIKit

class ProfileShadowView: UIView {
    private enum Constants {
        static let avatarImageHeight: CGFloat = 100
        static let avatarImageViewBorderWidth: CGFloat = 3.0
        static let avatarImageViewBorderColor: CGColor = UIColor.white.cgColor
    }
    
    lazy var shadowView: UIView = {
        shadowView = UIView(frame: .zero)
        shadowView.alpha = 0
        shadowView.backgroundColor = .white
        shadowView.toAutoLayout()
        
        return shadowView
    }()

    lazy var avatarImageView: UIImageView = {
        avatarImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: Constants.avatarImageHeight, height: Constants.avatarImageHeight))
        avatarImageView.image = UIImage(named: .avatarImageNamed)
        avatarImageView.translatesAutoresizingMaskIntoConstraints = true

        return avatarImageView
    }()
    
    lazy var closeButton: UIButton = {
        closeButton = UIButton(frame: .zero)
        closeButton.setImage(UIImage(systemName: "x.circle"), for: .normal)
        closeButton.alpha = 0
        closeButton.toAutoLayout()
        
        return closeButton
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .clear
        
        self.addSubviews([
            shadowView,
            avatarImageView,
            closeButton
        ])
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setupImage()
    }
    
    private func setupImage() {
        avatarImageView.clipsToBounds = true
        avatarImageView.roundedImage(
            cornerRadius: avatarImageView.frame.height / 2,
            borderWidth: Constants.avatarImageViewBorderWidth,
            borderColor: Constants.avatarImageViewBorderColor
        )
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            shadowView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            shadowView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            shadowView.widthAnchor.constraint(equalTo: self.widthAnchor),
            shadowView.heightAnchor.constraint(equalTo: self.heightAnchor),
            
            closeButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: .padding),
            closeButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -.padding),
        ])
    }
}

private extension String {
    static let avatarImageNamed = "avatar_cat"
}

private extension CGFloat {
    static let padding: CGFloat = 16
}
