//
//  LogInView.swift
//  Navigation
//
//  Created by Азамат Агатаев on 05.11.2021.
//

import UIKit


final class LogInView: UIView {
    private let theme: Theme = .current
    
    weak var delegate: LogInViewControllerDelegate?
    weak var checkerDelegate: LogInViewControllerCheckerDelegate?
    
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
    
    private lazy var logoImageView: UIImageView = {
        logoImageView = UIImageView(image: Constants.Logo.image)
        logoImageView.toAutoLayout()
        
        return logoImageView
    }()
    
    private lazy var emailOfPhoneTextField: UITextField = {
        emailOfPhoneTextField = UITextField(frame: .zero)
        emailOfPhoneTextField.placeholder = .emailOfPhonePlaceholder
        emailOfPhoneTextField.textColor = Constants.TextField.textColor
        emailOfPhoneTextField.font = Constants.TextField.font
        emailOfPhoneTextField.autocapitalizationType = .none
        emailOfPhoneTextField.tintColor = UIColor(named: "color")
        
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
    
    private lazy var passwordTextField: UITextField = {
        passwordTextField = UITextField(frame: .zero)
        passwordTextField.placeholder = .passwordPlaceholder
        passwordTextField.isSecureTextEntry = true
        passwordTextField.tintColor = UIColor(named: "color")
        
        passwordTextField.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        passwordTextField.layer.cornerRadius = Constants.TextField.cornerRadius
        passwordTextField.layer.borderWidth = Constants.TextField.borderWidth
        passwordTextField.layer.borderColor = Constants.TextField.borderColor
        
        passwordTextField.backgroundColor = .systemGray6
        
        passwordTextField.setLeftPaddingPoints(.TextField.padding)
        passwordTextField.setRightPaddingPoints(.TextField.padding)
        passwordTextField.rightViewMode = UITextField.ViewMode.always
        
        passwordTextField.toAutoLayout()
        
        return passwordTextField
    }()
    
    private lazy var formStackView: UIStackView = {
        formStackView = UIStackView(arrangedSubviews: [emailOfPhoneTextField, passwordTextField])
        formStackView.spacing = 0
        formStackView.axis = .vertical
        formStackView.alignment = .fill
        formStackView.distribution = .fillEqually
        formStackView.toAutoLayout()
        
        return formStackView
    }()
    
    lazy var logInButton: CustomButton = {
        logInButton = CustomButton(
            title: .logInButtonTitle,
            titleColor: .white,
            onTap: { [weak self] in
                self?.tappedButton()
            }
        )
        logInButton.setBackgroundImage(Constants.Button.image?.alpha(1), for: .normal)
        logInButton.setBackgroundImage(Constants.Button.image?.alpha(0.8), for: [.selected, .highlighted, .disabled])
        
        logInButton.layer.cornerRadius = Constants.Button.cornerRadius
        logInButton.layer.masksToBounds = true
                
        logInButton.toAutoLayout()
        
        return logInButton
    }()
    
    private lazy var pickUpPassButton: CustomButton = {
        pickUpPassButton = CustomButton(
            title: .pickUpPassButtonTitle,
            titleColor: .white,
            onTap: { [weak self] in
                self?.pickUpPasswordButton()
            }
        )

        pickUpPassButton.setBackgroundImage(Constants.Button.image?.alpha(1), for: .normal)
        pickUpPassButton.setBackgroundImage(Constants.Button.image?.alpha(0.8), for: [.selected, .highlighted, .disabled])
        
        pickUpPassButton.layer.cornerRadius = Constants.Button.cornerRadius
        pickUpPassButton.layer.masksToBounds = true
        
        pickUpPassButton.toAutoLayout()
        
        return pickUpPassButton
    }()
    
    private lazy var biometryButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setBackgroundImage(UIImage(systemName: "touchid"), for: .normal)
        button.addTarget(self, action: #selector(biometryTapped), for: .touchUpInside)
        
        button.toAutoLayout()
        
        return button
    }()
    
    private lazy var signUpButton: CustomButton = {
        signUpButton = CustomButton(
            title: .signUpButtonTitle,
            titleColor: .white,
            onTap: { [weak self] in
                self?.signUpTapped()
            }
        )

        signUpButton.setBackgroundImage(Constants.Button.image?.alpha(1), for: .normal)
        signUpButton.setBackgroundImage(Constants.Button.image?.alpha(0.8), for: [.selected, .highlighted, .disabled])
        
        signUpButton.layer.cornerRadius = Constants.Button.cornerRadius
        signUpButton.layer.masksToBounds = true
        
        signUpButton.toAutoLayout()
        
        return signUpButton
    }()
    
    private lazy var spinnerView: UIActivityIndicatorView = {
        spinnerView = UIActivityIndicatorView(style: .large)
        spinnerView.toAutoLayout()
        return spinnerView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
                
        addSubviews([
            logoImageView,
            formStackView,
            spinnerView,
            logInButton,
            signUpButton,
        ])
        
        setupLayout()
        apply(theme: theme)
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
        
        let snipperViewConstraints: [NSLayoutConstraint] = [
            spinnerView.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor),
            spinnerView.bottomAnchor.constraint(equalTo: passwordTextField.bottomAnchor)
        ]
        
        let signUpButtonConstraints: [NSLayoutConstraint] = [
            signUpButton.topAnchor.constraint(equalTo: logInButton.bottomAnchor, constant: .FormStackView.padding),
            signUpButton.leadingAnchor.constraint(equalTo: logInButton.leadingAnchor),
            signUpButton.trailingAnchor.constraint(equalTo: logInButton.trailingAnchor),
            signUpButton.heightAnchor.constraint(equalToConstant: .Button.height)
        ]
        
        NSLayoutConstraint.activate(
            logoImageConstraints +
            formStackViewConstraints +
            logInButtonConstraints +
            signUpButtonConstraints +
            snipperViewConstraints
        )
    }
    
    private func tappedButton() {
        guard let vc = self.window?.rootViewController else { return }

        guard let emailText = emailOfPhoneTextField.text, !emailText.isEmpty else {
            CommonAlertError.present(vc: vc, with: "Input correct email")
            return
        }
        guard let passwordText = passwordTextField.text, !passwordText.isEmpty else {
            CommonAlertError.present(vc: vc, with: "Input correct password")
            return
        }
        
        checkerDelegate?.login(inputLogin: emailText, inputPassword: passwordText, completion: { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(_):
                self.delegate?.tappedButton(fullName: emailText)
            case .failure(let error):
                CommonAlertError.present(vc: vc, with: error.localizedDescription)
            }
        })
    }
    
    private func pickUpPasswordButton() {
        spinnerView.startAnimating()
        let bruteForceOperation = BruteForceOperation()
        bruteForceOperation.completionBlock = { [weak self] in
            DispatchQueue.main.async {
                self?.passwordTextField.text = bruteForceOperation.expectedPassword
                self?.passwordTextField.isSecureTextEntry = false
                self?.spinnerView.stopAnimating()
                self?.layoutIfNeeded()
            }
        }
        let operation = OperationQueue()
        operation.qualityOfService = .userInitiated
        operation.addOperation(bruteForceOperation)
    }
    
    @objc
    private func biometryTapped() {
        guard let vc = self.window?.rootViewController else { return }

        let local = LocalAuthorizationService()
        local.authorizeIfPossible { [weak self] flag in
            if flag {
                self?.delegate?.tappedButton(fullName: "")
            } else {
                CommonAlertError.present(vc: vc, with: "Error in biometry authorized!")
            }
        }
    }
    
    private func signUpTapped() {
        delegate?.pushSignUp()
    }
}

extension LogInView: ThemeAble {
    func apply(theme: Theme) {
        emailOfPhoneTextField.backgroundColor = theme.textLabel
        passwordTextField.backgroundColor = theme.textLabel
        logInButton.backgroundColor = theme.buttonColor
        pickUpPassButton.backgroundColor = theme.buttonColor
    }
}

private extension String {
    static let logoImageNamed = "logo"
    
    static let emailOfPhonePlaceholder = "Email address"
    static let passwordPlaceholder = "Password"
    
    static let logInButtonTitle = "Log In"
    static let blueImageNamed = "blue_pixel"
    static let pickUpPassButtonTitle = "Pick up password"
    static let signUpButtonTitle = "Sign Up"
}

private extension CGFloat {
    enum LogoImage {
        static let padding: CGFloat = 50
        static let width: CGFloat = 50
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
    
    enum BiometryButton {
        static let width: CGFloat = 50
    }
}
