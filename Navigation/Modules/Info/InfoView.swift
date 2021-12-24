//
//  InfoView.swift
//  Navigation
//
//  Created by a.agataev on 14.10.2021.
//

import UIKit

class InfoView: UIView {
    private enum Constains {
        static let width: CGFloat = 300
        static let height: CGFloat = 60
        static let bordetWidth: CGFloat = 1.0
        static let borderColor: CGColor = UIColor.blue.cgColor
    }
    
    lazy var alertButton: UIButton = {
        alertButton = UIButton(frame: .zero)
        alertButton.setTitle(.alertButtonTitle, for: .normal)
        alertButton.setTitleColor(.blue, for: .normal)
        alertButton.layer.borderColor = Constains.borderColor
        alertButton.layer.borderWidth = Constains.bordetWidth
        return alertButton
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(alertButton)
        
        alertButton.toAutoLayout()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            alertButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            alertButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            alertButton.widthAnchor.constraint(equalToConstant: Constains.width),
            alertButton.heightAnchor.constraint(equalToConstant: Constains.height)
        ])
    }
}

private extension String {
    static let alertButtonTitle = "Кнопка для вызова алерта"
}