//
//  ProfileView.swift
//  Navigation
//
//  Created by a.agataev on 11.10.2021.
//

import UIKit

class ProfileView: UIView {
    
    var profileImageView: UIImageView!
    var profileNameLabel: UILabel!
    var profileBirthdayLabel: UILabel!
    var profileCityLabel: UILabel!
    var profileIdentifierTextView: UITextView!
    
    private enum Constants {
        static let labelWidth: CGFloat = 207
        static let labelHeight: CGFloat = 30
        static let profileImageWidth: CGFloat = 104
        static let profileImageHeight: CGFloat = 124
        static let profileTextViewWidth: CGFloat = 341
        static let profileTextViewHeight: CGFloat = 274
        static let padding: CGFloat = 20
        static let labelPadding: CGFloat = 15
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupProfileImageView()
        setupLabel()
        setupTextField()
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupProfileImageView() {
        let profileImage = UIImage(named: .profileImageName)
        profileImageView = UIImageView(image: profileImage)
        profileImageView.frame = CGRect.zero
        
        self.addSubview(profileImageView)
        
        profileImageView.toAutoLayout()
    }
    
    private func setupLabel() {
        profileNameLabel = UILabel(frame: .zero)
        profileNameLabel.text = .profileNameLabel
        profileNameLabel.backgroundColor = .blue
        
        profileBirthdayLabel = UILabel(frame: .zero)
        profileBirthdayLabel.text = .profileBirthdayLabel
        profileBirthdayLabel.backgroundColor = .green
        
        profileCityLabel = UILabel(frame: .zero)
        profileCityLabel.text = .profileCityLabel
        profileCityLabel.backgroundColor = .orange
        
        self.addSubviews([
            profileNameLabel,
            profileBirthdayLabel,
            profileCityLabel
        ])
        
        profileNameLabel.toAutoLayout()
        profileBirthdayLabel.toAutoLayout()
        profileCityLabel.toAutoLayout()
    }
    
    private func setupTextField() {
        profileIdentifierTextView = UITextView(frame: .zero)
        profileIdentifierTextView.text = .profileText
        
        self.addSubview(profileIdentifierTextView)
        
        profileIdentifierTextView.toAutoLayout()
    }
    
    private func setupLayout() {
        let profileImageConstraints: [NSLayoutConstraint] = [
            profileImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.padding),
            profileImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: Constants.padding),
            profileImageView.widthAnchor.constraint(lessThanOrEqualToConstant: Constants.profileImageWidth),
            profileImageView.heightAnchor.constraint(lessThanOrEqualToConstant: Constants.profileImageHeight),
        ]
        
        let profileNameConstraints: [NSLayoutConstraint] = [
            profileNameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: Constants.padding),
            profileNameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: Constants.padding),
            profileNameLabel.widthAnchor.constraint(equalToConstant: Constants.labelWidth),
            profileNameLabel.heightAnchor.constraint(equalToConstant: Constants.labelHeight),
        ]
        
        let profileBirtdayConstraints: [NSLayoutConstraint] = [
            profileBirthdayLabel.topAnchor.constraint(equalTo: profileNameLabel.bottomAnchor, constant: Constants.labelPadding),
            profileBirthdayLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: Constants.padding),
            profileBirthdayLabel.widthAnchor.constraint(equalToConstant: Constants.labelWidth),
            profileBirthdayLabel.heightAnchor.constraint(equalToConstant: Constants.labelHeight),
        ]
        
        let profileCityConstraints: [NSLayoutConstraint] = [
            profileCityLabel.topAnchor.constraint(equalTo: profileBirthdayLabel.bottomAnchor, constant: Constants.labelPadding),
            profileCityLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: Constants.padding),
            profileCityLabel.widthAnchor.constraint(equalToConstant: Constants.labelWidth),
            profileCityLabel.heightAnchor.constraint(equalToConstant: Constants.labelHeight),
        ]
        
        let profileIdentifierConstraints: [NSLayoutConstraint] = [
            profileIdentifierTextView.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: Constants.padding),
            profileIdentifierTextView.topAnchor.constraint(equalTo: profileCityLabel.bottomAnchor, constant: Constants.padding),
            profileIdentifierTextView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.padding),
            profileIdentifierTextView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constants.padding),
            profileIdentifierTextView.heightAnchor.constraint(greaterThanOrEqualToConstant: Constants.profileImageHeight),
            profileIdentifierTextView.widthAnchor.constraint(greaterThanOrEqualToConstant: Constants.profileImageWidth),
        ]
        
        NSLayoutConstraint.activate(
            profileImageConstraints +
            profileNameConstraints +
            profileBirtdayConstraints +
            profileCityConstraints +
            profileIdentifierConstraints
        )
    }
    
}

private extension String {
    static let profileImageName = "avatar"
    static let profileNameLabel = "Имя"
    static let profileBirthdayLabel = "Дата рождения"
    static let profileCityLabel = "Город"
    static let profileText = """
    Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda.
    """
}
