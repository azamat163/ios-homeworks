//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by a.agataev on 20.10.2021.
//

import UIKit
import SnapKit

class ProfileHeaderView: UIView {
    
    private var statusText: String = ""
    
    weak var delegate: ProfileViewControllerDelegate?

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
        avatarImageView.isUserInteractionEnabled = true
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(onTappedAvatarImage(_:)))
        avatarImageView.addGestureRecognizer(tapGestureRecognizer)

        return avatarImageView
    }()
    
    private lazy var fullNameLabel: UILabel = {
        fullNameLabel = UILabel(frame: .zero)
        fullNameLabel.font = Constants.fullNameLabelFont
        fullNameLabel.text = .fullNameLabelText
        fullNameLabel.textColor = Constants.fullNameLabelColor
        
        return fullNameLabel
    }()
    
    private lazy var statusLabel: UILabel = {
        statusLabel = UILabel(frame: .zero)
        statusLabel.font = Constants.statusLabelFont
        statusLabel.text = .statusLabelText
        statusLabel.textColor = Constants.statusLabelColor
        
        return statusLabel
    }()
    
    private lazy var statusTextField: UITextField = {
        statusTextField = UITextField(frame: .zero)
        statusTextField.backgroundColor = Constants.statusTextFieldBackgroundColor
        statusTextField.placeholder = .placeholderText
        statusTextField.addTarget(self, action: #selector(statusTextChanged), for: .editingChanged)

        return statusTextField
    }()
    
    private lazy var setStatusButton: CustomButton = {
        setStatusButton = CustomButton(
            title: .setStatusButtonText,
            titleColor: .white,
            onTap: { [weak self] in
                self?.buttonPressed()
            }
        )
        setStatusButton.backgroundColor = Constants.setStatusButtonColor
        
        return setStatusButton
    }()
    
    private lazy var closeButton: UIButton = {
        closeButton = UIButton(frame: .zero)
        closeButton.setImage(UIImage(systemName: "x.circle"), for: .normal)
        closeButton.alpha = 0
        
        return closeButton
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubviews([
            avatarImageView,
            fullNameLabel,
            statusLabel,
            statusTextField,
            setStatusButton,
            closeButton
        ])
        
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
    
    // MARK: - Setting layout constraints with SnapKit
    
    private func setupLayout() {
        avatarImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(Constants.padding)
            make.top.equalToSuperview().offset(Constants.padding)
            make.width.equalTo(Constants.avatarImageHeight)
            make.height.equalTo(Constants.avatarImageHeight)
        }
        
        fullNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Constants.labelPadding)
            make.leading.equalTo(avatarImageView.snp.trailing).offset(Constants.padding)
        }
        
        statusLabel.snp.makeConstraints { make in
            make.leading.equalTo(fullNameLabel.snp.leading)
            make.top.equalTo(fullNameLabel.snp.bottom).offset(Constants.textPadding)
        }
        
        statusTextField.snp.makeConstraints { make in
            make.leading.equalTo(fullNameLabel.snp.leading)
            make.top.equalTo(statusLabel.snp.bottom).offset(Constants.padding)
            make.trailing.equalToSuperview().offset(-Constants.padding)
            make.height.equalTo(Constants.statusTextFieldHeight)
        }
        
        setStatusButton.snp.makeConstraints { make in
            make.top.equalTo(statusTextField.snp.bottom).offset(Constants.buttonPadding)
            make.leading.equalTo(avatarImageView.snp.leading)
            make.trailing.equalTo(statusTextField.snp.trailing)
            make.height.equalTo(Constants.setStatusButtonHeight)
        }
        
        closeButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Constants.padding)
            make.trailing.equalToSuperview().offset(-Constants.padding)
        }
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
    
    private func buttonPressed() {
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
    
    @objc func onTappedAvatarImage(_ sender: UITapGestureRecognizer) {
        delegate?.onTappedAvatarImage(sender)
    }
}

extension ProfileHeaderView {
    public func configure(with user: User) {
        avatarImageView.image = UIImage(named: user.avatar)
        fullNameLabel.text = user.fullName
        statusLabel.text = user.status
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
