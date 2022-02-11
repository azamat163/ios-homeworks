//
//  CustomButton.swift
//  Navigation
//
//  Created by Азамат Агатаев on 23.01.2022.
//

import Foundation
import UIKit

final class CustomButton: UIButton {
    private var title: String
    private var titleColor: UIColor
    private var onTap: (() -> Void)?
    
    init(title: String, titleColor: UIColor, onTap: (() -> Void)?) {
        self.title = title
        self.titleColor = titleColor
        self.onTap = onTap
        
        super.init(frame: .zero)
        
        setTitle(title, for: .normal)
        setTitleColor(titleColor, for: .normal)
        addTarget(self, action: #selector(handleButtonTapped), for: .touchUpInside)
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    private func handleButtonTapped() {
        onTap?()
    }
}
