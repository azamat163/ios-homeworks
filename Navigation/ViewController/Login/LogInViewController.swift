//
//  LogInViewController.swift
//  Navigation
//
//  Created by Азамат Агатаев on 05.11.2021.
//

import UIKit

class LogInViewController: UIViewController {
    
    weak var activeTextField: UITextField?
    
    lazy var logInView: LogInView = {
        logInView = LogInView(frame: .zero)
        logInView.toAutoLayout()
        
        return logInView
    }()
    
    lazy var scrollView: UIScrollView = {
        scrollView = UIScrollView(frame: .zero)
        scrollView.toAutoLayout()
        return scrollView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .white
        
        view.addSubview(scrollView)
        scrollView.addSubview(logInView)
        
        setupLogInView()
        logInView.delegate = self
        logInView.emailOfPhoneTextField.delegate = self
        logInView.passwordTextField.delegate = self
        
        configureKeyboardNotifications()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        NotificationCenter.default.removeObserver(self)
    }
    
    private func setupLogInView() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            logInView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            logInView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            logInView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            logInView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            logInView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            logInView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        ])
    }
    
    private func configureKeyboardNotifications() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: nil) {
            [weak self] notification in
                    self?.adjustForKeyboard(notification)
                }
        notificationCenter.addObserver(forName: UIResponder.keyboardWillChangeFrameNotification, object: nil, queue: nil) {
            [weak self] notification in
                    self?.adjustForKeyboard(notification)
        }
    }
        
    private func adjustForKeyboard(_ notification: Notification) {
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue
        else { return }
        
        guard let activeTextField = activeTextField else { return }

        let keyboardScreenEndFrame = keyboardValue.cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)

        if notification.name == UIResponder.keyboardWillHideNotification {
            scrollView.contentInset = UIEdgeInsets.zero
        } else {
            scrollView.contentInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardViewEndFrame.height, right: 0.0)
            
            let activeRect = activeTextField.convert(activeTextField.bounds, to: scrollView)
            scrollView.scrollRectToVisible(activeRect, animated: true)
        }
        
        scrollView.scrollIndicatorInsets = scrollView.contentInset
    }
}

extension LogInViewController: LogInViewControllerDelegate {
    
    func tappedButton(sender: UIButton) {
        let profileVc = ProfileViewController()
        navigationController?.pushViewController(profileVc, animated: true)
    }
}

extension LogInViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeTextField = textField
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        activeTextField = nil
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
