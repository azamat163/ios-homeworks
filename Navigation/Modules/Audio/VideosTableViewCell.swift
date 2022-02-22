//
//  VideosTableViewCell.swift
//  Navigation
//
//  Created by a.agataev on 21.02.2022.
//

import UIKit
import SnapKit

final class VideosTableViewCell: UITableViewCell {
    
    var viewModel: VideoViewModel?
    
    static var identifier: String {
        return String(describing: self)
    }
    
    private lazy var videoTitle: UILabel = {
        videoTitle = UILabel(frame: .zero)
        videoTitle.textColor = .black
        videoTitle.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        videoTitle.numberOfLines = 0
        videoTitle.textAlignment = .center
        return videoTitle
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(videoTitle)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        videoTitle.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(3)
            make.trailing.equalToSuperview().offset(-3)
        }
    }
    
}

extension VideosTableViewCell {
    func configure(with viewModel: VideoViewModel) {
        self.viewModel = viewModel
        
        videoTitle.text = viewModel.model.title
    }
}
