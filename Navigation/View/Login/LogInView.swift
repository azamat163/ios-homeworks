//
//  LogInView.swift
//  Navigation
//
//  Created by Азамат Агатаев on 05.11.2021.
//

import UIKit

class LogInView: UIView {
    
    var delegate: LogInViewControllerDelegate?
    
    //MARK: - constants
    
    private enum Constants {
        enum Logo {
            static let image: UIImage? = UIImage(named: .logoImageNamed)
        }
        
        enum TextField {
            static let font = UIFont.systemFont(ofSize: 16, weight: .regular)
            static let textColor: UIColor = .black
            static let cornerRadius: CGFloat = 10
            static let borderWidth: CGFloat = 0.5
            static let borderColor: CGColor = UIColor.lightGray.cgColor
        }
        
        enum Button {
            static let cornerRadius: CGFloat = 10
            static let image: UIImage? = UIImage(named: .blueImageNamed)
        }
    }
    
    lazy var logoImageView: UIImageView = {
        logoImageView = UIImageView(image: Constants.Logo.image)
        logoImageView.toAutoLayout()
        
        return logoImageView
    }()
    
    lazy var emailOfPhoneTextField: UITextField = {
        emailOfPhoneTextField = UITextField(frame: .zero)
        emailOfPhoneTextField.placeholder = .emailOfPhonePlaceholder
        emailOfPhoneTextField.textColor = Constants.TextField.textColor
        emailOfPhoneTextField.font = Constants.TextField.font
        emailOfPhoneTextField.autocapitalizationType = .none
        
        emailOfPhoneTextField.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        emailOfPhoneTextField.layer.cornerRadius = Constants.TextField.cornerRadius
        emailOfPhoneTextField.layer.borderWidth = Constants.TextField.borderWidth
        emailOfPhoneTextField.layer.borderColor = Constants.TextField.borderColor
        
        emailOfPhoneTextField.backgroundColor = .systemGray6

        emailOfPhoneTextField.setLeftPaddingPoints(.TextField.padding)
        emailOfPhoneTextField.setRightPaddingPoints(.TextField.padding)
        
        emailOfPhoneTextField.toAutoLayout()
        
        return emailOfPhoneTextField
    }()
    
    lazy var passwordTextField: UITextField = {
        passwordTextField = UITextField(frame: .zero)
        passwordTextField.placeholder = .passwordPlaceholder
        passwordTextField.isSecureTextEntry = true
        
        passwordTextField.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        passwordTextField.layer.cornerRadius = Constants.TextField.cornerRadius
        passwordTextField.layer.borderWidth = Constants.TextField.borderWidth
        passwordTextField.layer.borderColor = Constants.TextField.borderColor
        
        passwordTextField.backgroundColor = .systemGray6
        
        passwordTextField.setLeftPaddingPoints(.TextField.padding)
        passwordTextField.setRightPaddingPoints(.TextField.padding)
        
        passwordTextField.toAutoLayout()
        
        return passwordTextField
    }()
    
    lazy var formStackView: UIStackView = {
        formStackView = UIStackView(arrangedSubviews: [emailOfPhoneTextField, passwordTextField])
        formStackView.spacing = 0
        formStackView.axis = .vertical
        formStackView.alignment = .fill
        formStackView.distribution = .fillEqually
        formStackView.toAutoLayout()
        
        return formStackView
    }()
    
    lazy var logInButton: UIButton = {
        logInButton = UIButton(frame: .zero)
        logInButton.setTitle(.logInButtonTitle, for: .normal)
        logInButton.setTitleColor(.white, for: .normal)
        logInButton.setBackgroundImage(Constants.Button.image?.alpha(1), for: .normal)
        logInButton.setBackgroundImage(Constants.Button.image?.alpha(0.8), for: [.selected, .highlighted, .disabled])
        
        logInButton.layer.cornerRadius = Constants.Button.cornerRadius
        logInButton.layer.masksToBounds = true
        
        logInButton.addTarget(self, action: #selector(tappedButton(sender:)), for: .touchUpInside)
                
        logInButton.toAutoLayout()
        
        return logInButton
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
                
        addSubview(logoImageView)
        addSubview(formStackView)
        addSubview(logInButton)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        let logoImageConstraints: [NSLayoutConstraint] = [
            logoImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            logoImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: .LogoImage.padding),
            logoImageView.widthAnchor.constraint(equalToConstant: .LogoImage.width),
            logoImageView.heightAnchor.constraint(equalToConstant: .LogoImage.width)
        ]
        
        let formStackViewConstraints: [NSLayoutConstraint] = [
            formStackView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: .LogoImage.padding),
            formStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: .FormStackView.padding),
            formStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant:  -.FormStackView.padding),
            formStackView.heightAnchor.constraint(equalToConstant: .FormStackView.height)
        ]
        
        let logInButtonConstraints: [NSLayoutConstraint] = [
            logInButton.topAnchor.constraint(equalTo: formStackView.bottomAnchor, constant: .FormStackView.padding),
            logInButton.leadingAnchor.constraint(equalTo: formStackView.leadingAnchor),
            logInButton.trailingAnchor.constraint(equalTo: formStackView.trailingAnchor),
            logInButton.heightAnchor.constraint(equalToConstant: .Button.height)
        ]
        
        NSLayoutConstraint.activate(
            logoImageConstraints +
            formStackViewConstraints +
            logInButtonConstraints
        )
    }
    
    @objc func tappedButton(sender: UIButton) {
        guard let emailText = emailOfPhoneTextField.text else { return }
        guard let passwordText = passwordTextField.text else { return }
        if !emailText.isEmpty && !passwordText.isEmpty {
            delegate?.tappedButton(sender: sender)
        } else {
            animateButton()
        }
    }
    
    private func animateButton() {
        UIView.animate(withDuration: 0.5) {
            [weak self] in
            self?.logInButton.layer.borderWidth = 2
            self?.logInButton.layer.borderColor = UIColor.red.cgColor
            self?.layoutIfNeeded()
        }
    }
}

private extension String {
    static let logoImageNamed = "logo"
    
    static let emailOfPhonePlaceholder = "Email of phone"
    static let passwordPlaceholder = "Password"
    
    static let logInButtonTitle = "Log In"
    static let blueImageNamed = "blue_pixel"
}

private extension CGFloat {
    enum LogoImage {
        static let padding: CGFloat = 120
        static let width: CGFloat = 100
    }
    
    enum FormStackView {
        static let padding: CGFloat = 16
        static let height: CGFloat = 100
    }
    
    enum TextField {
        static let padding: CGFloat = 15
    }
    
    enum Button {
        static let height: CGFloat = 50
    }
}
