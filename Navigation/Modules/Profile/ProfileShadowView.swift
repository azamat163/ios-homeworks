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
        avatarImageView.clipsToBounds = true
        avatarImageView.roundedImage(
            cornerRadius: avatarImageView.frame.height / 2,
            borderWidth: Constants.avatarImageViewBorderWidth,
            borderColor: Constants.avatarImageViewBorderColor
        )
        avatarImageView.translatesAutoresizingMaskIntoConstraints = true

        return avatarImageView
    }()
    
    lazy var closeButton: UIButton = {
        closeButton = UIButton(frame: .zero)
        closeButton.setImage(UIImage(systemName: "x.circle"), for: .normal)
        closeButton.alpha = 0
        closeButton.addTarget(self, action: #selector(clickCloseButton), for: .touchUpInside)
        closeButton.toAutoLayout()
        
        return closeButton
    }()
    
    var profileAvatarView: UIView?
    
    convenience init(toView: UIView, frame: CGRect) {
        self.init(frame: frame)
        
        profileAvatarView = toView
        backgroundColor = .clear
        
        self.addSubviews([
            shadowView,
            avatarImageView,
            closeButton
        ])
        
        setupLayout()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            shadowView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            shadowView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            shadowView.widthAnchor.constraint(equalTo: self.widthAnchor),
            shadowView.heightAnchor.constraint(equalTo: self.heightAnchor),
            
            closeButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: .padding),
            closeButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -.padding)
        ])
    }
    
    private func avatarImageConstraints() -> [NSLayoutConstraint] {
        return [
            avatarImageView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: .padding),
            avatarImageView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: .padding),
            avatarImageView.widthAnchor.constraint(equalToConstant: Constants.avatarImageHeight),
            avatarImageView.heightAnchor.constraint(equalToConstant: Constants.avatarImageHeight)
        ]
    }
    
    func animationAvatarImage() {
        UIView.animate(withDuration: 0.5, delay: 0, options: [.beginFromCurrentState], animations: {
            self.avatarImageView.frame.size.width = self.bounds.size.width
            self.avatarImageView.frame.size.height = self.bounds.size.width
            self.avatarImageView.center = self.center
            
            self.avatarImageView.layer.cornerRadius = 0
            self.shadowView.alpha = 0.5
            
            self.layoutIfNeeded()
        })
    }
    
    func animationCloseButton() {
        UIView.animate(withDuration: 0.3, delay: 0, options: [.beginFromCurrentState], animations: {
            self.closeButton.alpha = 1.0
            
            self.layoutIfNeeded()
        })
    }
    
    @objc func clickCloseButton() {
        self.layoutIfNeeded()
        avatarImageView.toAutoLayout()
        NSLayoutConstraint.activate(avatarImageConstraints())

        UIView.animateKeyframes(withDuration: 2.0, delay: 1.0, options: .calculationModeCubicPaced, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5, animations: {
                self.avatarImageView.clipsToBounds = true
                self.avatarImageView.roundedImage(
                    cornerRadius: self.avatarImageView.frame.height / 2,
                    borderWidth: Constants.avatarImageViewBorderWidth,
                    borderColor: Constants.avatarImageViewBorderColor
                )
                
                self.layoutIfNeeded()
            })
            
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5, animations: {
                self.removeFromSuperview()
                self.profileAvatarView?.isHidden = false
                
                self.layoutIfNeeded()
            })
        })
    }
}

private extension String {
    static let avatarImageNamed = "avatar_cat"
}

private extension CGFloat {
    static let padding: CGFloat = 16
}
