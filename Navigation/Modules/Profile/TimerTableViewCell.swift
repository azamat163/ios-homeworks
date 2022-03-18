//
//  TimerTableViewCell.swift
//  Navigation
//
//  Created by a.agataev on 07.02.2022.
//

import UIKit
import SnapKit

class TimerTableViewCell: UITableViewCell {
    
    lazy var titleLabel: UILabel = {
        titleLabel = UILabel(frame: .zero)
        titleLabel.font = UIFont.boldSystemFont(ofSize: 14)
        titleLabel.textColor = .black
        
        return titleLabel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(titleLabel)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalTo(contentView.snp.centerX)
            make.centerY.equalTo(contentView.snp.centerY)
        }
    }
}
