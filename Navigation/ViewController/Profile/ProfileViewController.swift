//
//  ProfileViewController.swift
//  Navigation
//
//  Created by a.agataev on 11.10.2021.
//

import UIKit

class ProfileViewController: UIViewController {
    
    //MARK: - constants
    
    private enum Constants {
        static let profileHeaderViewHeight: CGFloat = 222
        
        static let profileButtonColor: UIColor = .systemBlue
    }
    
    private var statusText: String = ""
    
    lazy var profileHeaderView: ProfileHeaderView = {
        profileHeaderView = ProfileHeaderView()
        profileHeaderView.setStatusButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        profileHeaderView.statusTextField.addTarget(self, action: #selector(statusTextChanged(_:)), for: .editingChanged)
        
        return profileHeaderView
    }()
    
    lazy var profileButton: UIButton = {
        profileButton = UIButton(frame: .zero)
        profileButton.backgroundColor = Constants.profileButtonColor
        profileButton.setTitle(.profileButtonTitle, for: .normal)
        profileButton.setTitleColor(.white, for: .normal)
        
        return profileButton
    }()
    
    
    override func loadView() {
        super.loadView()
       
        profileHeaderView.backgroundColor = .lightGray
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let views: [UIView] = [
            profileHeaderView,
            profileButton
        ]
        
        view.addSubviews(views)
        
        views.forEach{ $0.toAutoLayout() }
        
        setup()
    }
    
    private func setup() {
        setupProfileHeaderViewLayout()
        setupProfileButtonLayout()
    }
    
    //MARK: - setup profileHeaderView layout
    
    private func setupProfileHeaderViewLayout() {
        NSLayoutConstraint.activate([
            profileHeaderView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            profileHeaderView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            profileHeaderView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            profileHeaderView.heightAnchor.constraint(equalToConstant: Constants.profileHeaderViewHeight)
        ])
    }
    
    private func setupProfileButtonLayout() {
        NSLayoutConstraint.activate([
            profileButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            profileButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            profileButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    @objc func buttonPressed() {
        guard !statusText.isEmpty else {
            statusTextFieldAnimate()
            return
        }
        
        profileHeaderView.statusLabel.text = statusText
    }
    
    private func statusTextFieldAnimate() {
        UIView.animate(withDuration: 0.5) {
            [weak self] in
            self?.profileHeaderView.statusTextField.layer.borderWidth = 2
            self?.profileHeaderView.statusTextField.layer.borderColor = UIColor.red.cgColor
            self?.view.layoutIfNeeded()
        }
    }
    
    @objc func statusTextChanged(_ textField: UITextField) {
        statusText = textField.text ?? " "
    }
}

//MARK: - extension string

private extension String {
    static let profileButtonTitle = "Кнопка"
}
