//
//  RegistrationViewController.swift
//  Navigation
//
//  Created by a.agataev on 04.10.2022.
//

import UIKit
import SnapKit

class RegistrationViewController: UIViewController {
    private lazy var logoImageView: UIImageView = {
        logoImageView = UIImageView(image: UIImage(named: "logo"))
        return logoImageView
    }()
        
    private lazy var emailTextField: UITextField = {
        emailTextField = UITextField(frame: .zero)
        emailTextField.placeholder = "Email address"
        emailTextField.textColor = .black
        emailTextField.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        emailTextField.autocapitalizationType = .none
        emailTextField.tintColor = UIColor(named: "color")
        emailTextField.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        emailTextField.layer.cornerRadius = 10
        emailTextField.layer.borderWidth = 0.5
        emailTextField.layer.borderColor = UIColor.lightGray.cgColor
        emailTextField.backgroundColor = .systemGray6
        emailTextField.setLeftPaddingPoints(15)
        emailTextField.setRightPaddingPoints(15)
        return emailTextField
    }()
    
    private lazy var passwordTextField: UITextField = {
        passwordTextField = UITextField(frame: .zero)
        passwordTextField.placeholder = "Password"
        passwordTextField.isSecureTextEntry = true
        passwordTextField.tintColor = UIColor(named: "color")
        passwordTextField.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        passwordTextField.layer.cornerRadius = 10
        passwordTextField.layer.borderWidth = 0.5
        passwordTextField.layer.borderColor = UIColor.lightGray.cgColor
        passwordTextField.backgroundColor = .systemGray6
        passwordTextField.setLeftPaddingPoints(15)
        passwordTextField.setRightPaddingPoints(15)
        passwordTextField.rightViewMode = UITextField.ViewMode.always
        return passwordTextField
    }()
    
    private lazy var formStackView: UIStackView = {
        formStackView = UIStackView(
            arrangedSubviews: [
                emailTextField,
                passwordTextField
            ]
        )
        formStackView.spacing = 0
        formStackView.axis = .vertical
        formStackView.alignment = .fill
        formStackView.distribution = .fillEqually
        return formStackView
    }()
    
    private lazy var continueButton: CustomButton = {
        continueButton = CustomButton(
            title: "Continue",
            titleColor: .white,
            onTap: { [weak self] in
                self?.continueTapped()
            }
        )
        continueButton.setBackgroundImage(
            UIImage(named: "blue_pixel")?.alpha(1),
            for: .normal
        )
        continueButton.setBackgroundImage(
            UIImage(named: "blue_pixel")?.alpha(0.8),
            for: [.selected, .highlighted, .disabled]
        )
        continueButton.layer.cornerRadius = 10
        continueButton.layer.masksToBounds = true
        return continueButton
    }()
    
    private let viewModel: RegistrationViewModel
    
    init(viewModel: RegistrationViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Create an account"
        view.backgroundColor = .white
        
        [
            logoImageView,
            formStackView,
            continueButton
        ].forEach {
            view.addSubview($0)
        }
        setupLayout()
        setupViewModel()
    }
    
    private func continueTapped() {
        let email = self.emailTextField.text
        let password = self.passwordTextField.text
        viewModel.send(.showMainVc(email, password))
    }
}

private extension RegistrationViewController {
    private func setupLayout() {
        logoImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(50)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(50)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        
        formStackView.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(50)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        continueButton.snp.makeConstraints { make in
            make.top.equalTo(formStackView.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(50)
        }
    }
}

private extension RegistrationViewController {
    private func setupViewModel() {
        viewModel.onStateChanged = { [weak self] state in
            guard let self = self else { return }
            switch state {
            case .initial:
                print("initial")
            case .showEmptyAlert(let error):
                CommonAlertError.present(vc: self, message: error)
            }
        }
    }
}
