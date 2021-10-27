//
//  FeedView.swift
//  Navigation
//
//  Created by a.agataev on 14.10.2021.
//

import UIKit

class FeedView: UIView {
    private enum Constains {
        static let width: CGFloat = 200
        static let height: CGFloat = 60
        static let bordetWidth: CGFloat = 1.0
        static let borderColor: CGColor = UIColor.blue.cgColor
        
        static let axis = NSLayoutConstraint.Axis.vertical
        static let spacing: CGFloat = 10.0
    }
    
    lazy var firstPostButton: UIButton = {
        firstPostButton = UIButton(frame: .zero)
        firstPostButton.setTitle(.firstPostButtonTitle, for: .normal)
        firstPostButton.setTitleColor(.blue, for: .normal)
        firstPostButton.layer.borderColor = Constains.borderColor
        firstPostButton.layer.borderWidth = Constains.bordetWidth
        return firstPostButton
    }()
    
    lazy var secondPostButton: UIButton = {
        secondPostButton = UIButton(frame: .zero)
        secondPostButton.setTitle(.secondPostButtonTitle, for: .normal)
        secondPostButton.setTitleColor(.blue, for: .normal)
        secondPostButton.layer.borderColor = Constains.borderColor
        secondPostButton.layer.borderWidth = Constains.bordetWidth
        return secondPostButton
    }()
    
    lazy var stackView: UIStackView = {
        stackView = UIStackView(frame: .zero)
        stackView.axis = Constains.axis
        stackView.spacing = Constains.spacing
        let views = [
            firstPostButton,
            secondPostButton
        ]
        
        views.forEach { stackView.addArrangedSubview($0) }
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(stackView)
        
        stackView.toAutoLayout()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
    }
}

private extension String {
    static let firstPostButtonTitle = "Первая кнопка"
    static let secondPostButtonTitle = "Вторая кнопка"
}
