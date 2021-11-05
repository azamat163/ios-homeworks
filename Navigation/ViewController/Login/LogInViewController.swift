//
//  LogInViewController.swift
//  Navigation
//
//  Created by Азамат Агатаев on 05.11.2021.
//

import UIKit

class LogInViewController: UIViewController {
    
    var activeTextField: UITextField?
    var scrollOffset : CGFloat = 0
    var distance : CGFloat = 0
    
    lazy var logInView: LogInView = {
        logInView = LogInView(frame: .zero)
        logInView.toAutoLayout()
        
        return logInView
    }()
    
    lazy var scrollView: UIScrollView = {
        scrollView = UIScrollView(frame: .zero)
        scrollView.automaticallyAdjustsScrollIndicatorInsets = true
        scrollView.toAutoLayout()
        return scrollView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .white
        
        setupLogInView()
        logInView.delegate = self
        
        registerNotifications()
    }
    
    private func setupLogInView() {
        scrollView.addSubview(logInView)
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            logInView.topAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.topAnchor),
            logInView.bottomAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.bottomAnchor),
            logInView.leadingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.leadingAnchor),
            logInView.trailingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.trailingAnchor),
        ])
    }
    
    private func registerNotifications() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    var isExpand: Bool = false
    
    @objc func keyboardWillShow(notification: Notification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize.height , right: 0.0)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
        
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
}

extension LogInViewController: LogInViewControllerDelegate {
    
    func tappedButton(sender: UIButton) {
        let profileVc = ProfileViewController()
        navigationController?.pushViewController(profileVc, animated: true)
    }
}
