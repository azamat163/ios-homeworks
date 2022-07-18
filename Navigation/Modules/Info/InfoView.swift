//
//  InfoView.swift
//  Navigation
//
//  Created by a.agataev on 14.10.2021.
//

import UIKit
import SnapKit

final class InfoView: UIView {
    
    weak var delegate: InfoViewControllerDelegate?
    
    private enum Constains {
        static let bordetWidth: CGFloat = 1.0
        static let borderColor: CGColor = UIColor.blue.cgColor
    }
    
    private lazy var alertButton: CustomButton = {
        alertButton = CustomButton(
            title: .alertButtonTitle,
            titleColor: .blue,
            onTap: { [weak self] in
                self?.buttonTapped()
            }
        )
        alertButton.layer.borderColor = Constains.borderColor
        alertButton.layer.borderWidth = Constains.bordetWidth
        
        return alertButton
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .blue
        label.textAlignment = .center
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.layer.borderColor = Constains.borderColor
        label.layer.borderWidth = Constains.bordetWidth
        
        return label
    }()
    
    private lazy var orbitalPeriodLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .blue
        label.textAlignment = .center
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.layer.borderColor = Constains.borderColor
        label.layer.borderWidth = Constains.bordetWidth
        
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            alertButton,
            titleLabel,
            orbitalPeriodLabel
        ])
        stackView.spacing = 3
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(stackView)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setup() {
        stackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().offset(-100)
        }
    }
    
    private func buttonTapped() {
        delegate?.clickAlertAction()
    }
}

extension InfoView {
    func configureTitle(model: TodosModel) {
        titleLabel.text = model.title
    }
    
    func configureOrbitalPeriod(model: PlanetModel) {
        orbitalPeriodLabel.text = model.orbitalPeriod
    }
}

private extension String {
    static let alertButtonTitle = String(localized: "info.button.title")
}
