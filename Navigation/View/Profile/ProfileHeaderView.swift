//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by a.agataev on 20.10.2021.
//

import UIKit

class ProfileHeaderView: UIView {
    
    // MARK: - constants
    private enum Constants {
        static let logoImage: UIImage? = UIImage(named: .logoImageNamed)
        static let logoImageViewFrame: CGRect = CGRect(x: 0, y: 0, width: 100, height: 100)
        static let logoImageViewBorderWidth: CGFloat = 3.0
        static let logoImageViewBorderColor: CGColor = UIColor.white.cgColor
        
        static let nameLabelFont: UIFont = UIFont.systemFont(ofSize: 18, weight: .bold)
        static let nameLabelColor: UIColor = .black
        
        static let statusLabelFont: UIFont = UIFont.systemFont(ofSize: 14, weight: .regular)
        static let statusLabelColor: UIColor = .gray
        
        static let statusTextFieldFont: UIFont = UIFont.systemFont(ofSize: 15, weight: .regular)
        static let statusTextFieldCornerRadius: CGFloat = 12
        static let statusTextFieldColor: UIColor = .black
        static let statusTextFieldBackgroundColor: UIColor = .white
        static let statusTextFieldBorderWidth: CGFloat = 1
        static let statusTextFieldBorderColor: CGColor = UIColor.black.cgColor
        static let statusTextFieldHeight: CGFloat = 40.0
        static let statusTextFieldWidth: CGFloat = 300.0
        
        static let showStatusButtonColor: UIColor = .systemBlue
        static let showStatusButtonCornerRadius: CGFloat = 12.0
        static let showStatusShadowOffset: CGSize = CGSize(width: 4, height: 4)
        static let showStatusShadowRadius: CGFloat = 4.0
        static let showStatusShadowColor: CGColor = UIColor.black.cgColor
        static let showStatusShadowOpacity: Float = 0.7
        static let showStatusButtonHeight: CGFloat = 50.0
        
        static let padding: CGFloat = 16
        static let labelPadding: CGFloat = 27
        static let textPadding: CGFloat = 34
    }
    
    lazy var logoImageView: UIImageView = {
        logoImageView = UIImageView(image: Constants.logoImage)
        logoImageView.frame = Constants.logoImageViewFrame
      

        return logoImageView
    }()
    
    lazy var nameLabel: UILabel = {
        nameLabel = UILabel(frame: .zero)
        nameLabel.font = Constants.nameLabelFont
        nameLabel.text = .nameLabelText
        nameLabel.textColor = Constants.nameLabelColor
        
        return nameLabel
    }()
    
    lazy var statusLabel: UILabel = {
        statusLabel = UILabel(frame: .zero)
        statusLabel.font = Constants.statusLabelFont
        statusLabel.text = .statusLabelText
        statusLabel.textColor = Constants.statusLabelColor
        
        return statusLabel
    }()
    
    lazy var statusTextField: UITextField = {
        statusTextField = UITextField(frame: .zero)
        statusTextField.backgroundColor = Constants.statusTextFieldBackgroundColor
        statusTextField.placeholder = .placeholderText

        return statusTextField
    }()
    
    lazy var showStatusButton: UIButton = {
        showStatusButton = UIButton(frame: .zero)
        showStatusButton.backgroundColor = Constants.showStatusButtonColor
        showStatusButton.setTitleColor(.white, for: .normal)
        showStatusButton.setTitle(.showStatusButtonText, for: .normal)
        
        return showStatusButton
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let views: [UIView] = [
            logoImageView,
            nameLabel,
            statusLabel,
            statusTextField,
            showStatusButton
        ]

        self.addSubviews(views)
        views.forEach { $0.toAutoLayout() }

        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setupImage()
        setupStatusTextField()
        setupStatusButton()
        
        setupPaddingTextField()
    }
    
    // MARK: - Setting layout constraints
    
    private func setupLayout() {
        let logoImageConstraints: [NSLayoutConstraint] = [
            logoImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.padding),
            logoImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: Constants.padding),
        ]
        
        let nameLabelConstraints: [NSLayoutConstraint] = [
            nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: Constants.labelPadding),
            nameLabel.leadingAnchor.constraint(equalTo: logoImageView.trailingAnchor, constant: Constants.padding)
        ]
        
        let statusLabelConstraints: [NSLayoutConstraint] = [
            statusLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            statusLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: Constants.textPadding),
        ]
        
        let statusTextFieldConstraints: [NSLayoutConstraint] = [
            statusTextField.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            statusTextField.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: Constants.padding),
            statusTextField.trailingAnchor.constraint(equalTo: showStatusButton.trailingAnchor),
            statusTextField.heightAnchor.constraint(equalToConstant: Constants.statusTextFieldHeight),
            statusTextField.widthAnchor.constraint(lessThanOrEqualToConstant: Constants.statusTextFieldWidth),
        ]
        
        let showStatusButtonConstraints: [NSLayoutConstraint] = [
            showStatusButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.padding),
            showStatusButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant:  -Constants.padding),
            showStatusButton.heightAnchor.constraint(equalToConstant: Constants.showStatusButtonHeight),
            showStatusButton.topAnchor.constraint(equalTo: statusTextField.bottomAnchor, constant: Constants.padding)
        ]
        
        NSLayoutConstraint.activate(
            logoImageConstraints +
            nameLabelConstraints +
            statusLabelConstraints +
            statusTextFieldConstraints +
            showStatusButtonConstraints
        )
    }
    
    //MARK: - Settings layer
    
    private func setupImage() {
        logoImageView.clipsToBounds = true
        logoImageView.roundedImage(
            cornerRadius: logoImageView.frame.height / 2,
            borderWidth: Constants.logoImageViewBorderWidth,
            borderColor: Constants.logoImageViewBorderColor
        )
    }
    
    private func setupStatusTextField() {
        statusTextField.roundedTextField(
            cornerRadius: Constants.statusTextFieldCornerRadius,
            borderWidth: Constants.statusTextFieldBorderWidth,
            borderColor: Constants.statusTextFieldBorderColor
        )
    }
    
    private func setupStatusButton() {
        showStatusButton.roundedButtonWithShadow(
            corderRadius: Constants.showStatusButtonCornerRadius,
            shadowOffset: Constants.showStatusShadowOffset,
            shadowRadius: Constants.showStatusShadowRadius,
            shadowColor: Constants.showStatusShadowColor,
            shadowOpacity: Constants.showStatusShadowOpacity
        )
    }
    
    private func setupPaddingTextField() {
        statusTextField.setLeftPaddingPoints(Constants.padding)
        statusTextField.setRightPaddingPoints(Constants.padding)
    }
}

// MARK: - Extension string

private extension String {
    static let logoImageNamed = "avatar_cat"
    static let nameLabelText = "Hipster Cat"
    static let statusLabelText = "Waiting for something..."
    static let placeholderText = "Set status..."
    static let showStatusButtonText = "Set status"
}
