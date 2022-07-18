//
//  FeedView.swift
//  Navigation
//
//  Created by a.agataev on 14.10.2021.
//

import UIKit


final class FeedView: UIView {
    
    weak var delegate: FeedViewControllerDelegate?
    
    private lazy var firstPostButton: CustomButton = {
        firstPostButton = CustomButton(
            title: .firstPostButtonTitle,
            titleColor: .blue,
            onTap: { [weak self] in
                self?.buttonTapped()
            }
        )
        firstPostButton.layer.borderColor = .borderColor
        firstPostButton.layer.borderWidth = .borderWidth
        
        return firstPostButton
    }()
    
    private lazy var secondPostButton: CustomButton = {
        secondPostButton = CustomButton(
            title: .secondPostButtonTitle,
            titleColor: .blue,
            onTap: { [weak self] in
                self?.buttonTapped()
            }
        )

        secondPostButton.layer.borderColor = .borderColor
        secondPostButton.layer.borderWidth = .borderWidth
        
        return secondPostButton
    }()
    
    private lazy var checkLabel: UILabel = {
        checkLabel = UILabel(frame: .zero)
        
        return checkLabel
    }()
    
    private lazy var checkTextField: UITextField = {
        checkTextField = UITextField(frame: .zero)
        checkTextField.backgroundColor = .white
        checkTextField.placeholder = .checkTextFieldTitle
        
        return checkTextField
    }()
    
    private lazy var checkButton: CustomButton = {
        checkButton = CustomButton(
            title: .buttonTitle,
            titleColor: .blue,
            onTap: { [weak self] in
                self?.changedTextTapped()
            }
        )
        checkButton.layer.borderColor = .borderColor
        checkButton.layer.borderWidth = .borderWidth

        return checkButton
    }()
    
    private lazy var stackView: UIStackView = {
        stackView = UIStackView(arrangedSubviews: [
            checkLabel,
            checkTextField,
            checkButton,
            firstPostButton,
            secondPostButton,
        ])
        stackView.axis = .vertical
        stackView.spacing = .spacing
        stackView.toAutoLayout()
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(stackView)
        setupLayout()
        
        NotificationCenter.default.addObserver(self, selector: #selector(checkPassword), name: .checkPassword, object: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
    }
    
    private func buttonTapped() {
        delegate?.clickButton()
    }
    
    @objc
    func checkPassword(notification: Notification) {
        guard let isCorrect = notification.object as? Bool else { return }
        isCorrect ? animateGreen() : animateRed()
    }
    
    func changedTextTapped()  {
        guard let inputText = checkTextField.text, !inputText.isEmpty else { return }
        delegate?.clickCheckerButton(word: inputText)
    }
    
    private func animateRed() {
        UIView.animate(withDuration: 0.5) {
            [weak self] in
            self?.checkLabel.textColor = .red
            self?.checkLabel.text = .checkFalseTitle
            self?.layoutIfNeeded()
        }
    }
    
    private func animateGreen() {
        UIView.animate(withDuration: 0.5) {
            [weak self] in
            self?.checkLabel.textColor = .green
            self?.checkLabel.text = .checkTrueTitle
            self?.layoutIfNeeded()
        }
    }
}

private extension String {
    static let firstPostButtonTitle = String(localized: "feed.first.post.button.title")
    static let secondPostButtonTitle = String(localized: "feed.second.post.button.title")
    static let buttonTitle = String(localized: "feed.button.title")
    static let checkTextFieldTitle = String(localized: "feed.check.textField.title")
    static let checkFalseTitle =  String(localized: "feed.check.false.title")
    static let checkTrueTitle = String(localized: "feed.check.true.title")
}

private extension CGFloat {
    static let borderWidth = 1.0
    static let spacing = 10.0
}

private extension CGColor {
    static let borderColor = UIColor.blue.cgColor
}
