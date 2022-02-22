//
//  RecordButtonTableViewCell.swift
//  Navigation
//
//  Created by a.agataev on 22.02.2022.
//

import UIKit
import SnapKit

final class RecordButtonTableViewCell: UITableViewCell {
    
    static var identifier: String {
        return String(describing: self)
    }
    
    private lazy var recordLabel: UILabel = {
        recordLabel = UILabel(frame: .zero)
        recordLabel.textColor = .black
        recordLabel.text = "Записать аудио"
        recordLabel.font = UIFont.systemFont(ofSize: 14)
        return recordLabel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(recordLabel)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        recordLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
}
