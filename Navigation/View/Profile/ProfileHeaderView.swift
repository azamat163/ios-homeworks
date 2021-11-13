//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by a.agataev on 20.10.2021.
//

import UIKit

class ProfileHeaderView: UIView {
    
    private var statusText: String = ""

    // MARK: - constants
    
    private enum Constants {
        static let avatarImage: UIImage? = UIImage(named: .avatarImageNamed)
        static let avatarImageHeight: CGFloat = 100
        static let avatarImageViewBorderWidth: CGFloat = 3.0
        static let avatarImageViewBorderColor: CGColor = UIColor.white.cgColor
        
        static let fullNameLabelFont: UIFont = UIFont.systemFont(ofSize: 18, weight: .bold)
        static let fullNameLabelColor: UIColor = .black
        
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
        
        static let setStatusButtonColor: UIColor = .systemBlue
        static let setStatusButtonCornerRadius: CGFloat = 12.0
        static let setStatusShadowOffset: CGSize = CGSize(width: 4, height: 4)
        static let setStatusShadowRadius: CGFloat = 4.0
        static let setStatusShadowColor: CGColor = UIColor.black.cgColor
        static let setStatusShadowOpacity: Float = 0.7
        static let setStatusButtonHeight: CGFloat = 50.0
        
        static let padding: CGFloat = 16
        static let labelPadding: CGFloat = 27
        static let textPadding: CGFloat = 34
        static let buttonPadding: CGFloat = 10
    }
    
    lazy var avatarImageView: UIImageView = {
        avatarImageView = UIImageView(image: Constants.avatarImage)

        return avatarImageView
    }()
    
    lazy var fullNameLabel: UILabel = {
        fullNameLabel = UILabel(frame: .zero)
        fullNameLabel.font = Constants.fullNameLabelFont
        fullNameLabel.text = .fullNameLabelText
        fullNameLabel.textColor = Constants.fullNameLabelColor
        
        return fullNameLabel
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
        statusTextField.addTarget(self, action: #selector(statusTextChanged), for: .editingChanged)

        return statusTextField
    }()
    
    lazy var setStatusButton: UIButton = {
        setStatusButton = UIButton(frame: .zero)
        setStatusButton.backgroundColor = Constants.setStatusButtonColor
        setStatusButton.setTitleColor(.white, for: .normal)
        setStatusButton.setTitle(.setStatusButtonText, for: .normal)
        setStatusButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        
        return setStatusButton
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let views: [UIView] = [
            avatarImageView,
            fullNameLabel,
            statusLabel,
            statusTextField,
            setStatusButton
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
        let avatarImageConstraints: [NSLayoutConstraint] = [
            avatarImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.padding),
            avatarImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: Constants.padding),
            avatarImageView.widthAnchor.constraint(equalToConstant: Constants.avatarImageHeight),
            avatarImageView.heightAnchor.constraint(equalToConstant: Constants.avatarImageHeight)
        ]
        
        let fullNameLabelConstraints: [NSLayoutConstraint] = [
            fullNameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: Constants.labelPadding),
            fullNameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: Constants.padding)
        ]
        
        let statusLabelConstraints: [NSLayoutConstraint] = [
            statusLabel.leadingAnchor.constraint(equalTo: fullNameLabel.leadingAnchor),
            statusLabel.topAnchor.constraint(equalTo: fullNameLabel.bottomAnchor, constant: Constants.textPadding),
//            statusLabel.bottomAnchor.constraint(equalTo: statusTextField.topAnchor, constant: -Constants.buttonPadding)
        ]
        
        let statusTextFieldConstraints: [NSLayoutConstraint] = [
            statusTextField.leadingAnchor.constraint(equalTo: fullNameLabel.leadingAnchor),
            statusTextField.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: Constants.padding),
            statusTextField.trailingAnchor.constraint(equalTo:  self.trailingAnchor, constant:  -Constants.padding),
            statusTextField.heightAnchor.constraint(equalToConstant: Constants.statusTextFieldHeight),
        ]
        
        let setStatusButtonConstraints: [NSLayoutConstraint] = [
            setStatusButton.topAnchor.constraint(equalTo: statusTextField.bottomAnchor, constant: Constants.buttonPadding),
            setStatusButton.leadingAnchor.constraint(equalTo:  avatarImageView.leadingAnchor),
            setStatusButton.trailingAnchor.constraint(equalTo:  statusTextField.trailingAnchor),
            setStatusButton.heightAnchor.constraint(equalToConstant: Constants.setStatusButtonHeight),
        ]
        
        NSLayoutConstraint.activate(
            avatarImageConstraints +
            fullNameLabelConstraints +
            statusLabelConstraints +
            statusTextFieldConstraints +
            setStatusButtonConstraints
        )
    }
    
    //MARK: - Settings layer
    
    private func setupImage() {
        avatarImageView.clipsToBounds = true
        avatarImageView.roundedImage(
            cornerRadius: avatarImageView.frame.height / 2,
            borderWidth: Constants.avatarImageViewBorderWidth,
            borderColor: Constants.avatarImageViewBorderColor
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
        setStatusButton.roundedButtonWithShadow(
            corderRadius: Constants.setStatusButtonCornerRadius,
            shadowOffset: Constants.setStatusShadowOffset,
            shadowRadius: Constants.setStatusShadowRadius,
            shadowColor: Constants.setStatusShadowColor,
            shadowOpacity: Constants.setStatusShadowOpacity
        )
    }
    
    private func setupPaddingTextField() {
        statusTextField.setLeftPaddingPoints(Constants.padding)
        statusTextField.setRightPaddingPoints(Constants.padding)
    }
    
    @objc func buttonPressed() {
        guard !statusText.isEmpty else {
            UIView.animate(withDuration: 0.5) {
                [weak self] in
                self?.statusTextField.layer.borderWidth = 2
                self?.statusTextField.layer.borderColor = UIColor.red.cgColor
                self?.layoutIfNeeded()
            }
            return
        }
        
        statusLabel.text = statusText
    }
    
    @objc func statusTextChanged(_ textField: UITextField) {
        statusText = textField.text ?? " "
    }
}

// MARK: - Extension string

private extension String {
    static let avatarImageNamed = "avatar_cat"
    static let fullNameLabelText = "Hipster Cat"
    static let statusLabelText = "Waiting for something..."
    static let placeholderText = "Set status..."
    static let setStatusButtonText = "Set status"
}
