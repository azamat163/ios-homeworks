//
//  AudioTableViewCell.swift
//  Navigation
//
//  Created by a.agataev on 17.02.2022.
//

import UIKit
import SnapKit

final class AudioTableViewCell: UITableViewCell {
    
    weak var delegate: AudiosViewControllerDelegate?
    var viewModel: AudioViewModel?
    
    static var identifier: String {
        return String(describing: self)
    }
    
    private lazy var audioTitle: UILabel = {
        audioTitle = UILabel(frame: .zero)
        audioTitle.textColor = .black
        audioTitle.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return audioTitle
    }()
    
    private lazy var audioArtist: UILabel = {
        audioArtist = UILabel(frame: .zero)
        audioArtist.textColor = .lightGray
        audioArtist.font = UIFont.systemFont(ofSize: 10, weight: .regular)
        return audioArtist
    }()
    
    private lazy var audioStackView: UIStackView = {
        audioStackView = UIStackView(arrangedSubviews: [
            audioTitle,
            audioArtist
        ])
        audioStackView.axis = .vertical
        audioStackView.alignment = .leading
        audioStackView.spacing = 3
        audioStackView.distribution = .fillEqually
        return audioStackView
    }()
    
    private lazy var audioImageView: UIImageView = {
        audioImageView = UIImageView(frame: .zero)
        audioImageView.layer.cornerRadius = 12
        audioImageView.layer.masksToBounds = true
        return audioImageView
    }()
    
    private lazy var audioPlayImageView: UIImageView = {
        audioPlayImageView = UIImageView(frame: .zero)
        audioPlayImageView.image = UIImage(systemName: "play.fill")
        audioPlayImageView.backgroundColor = .white
        audioPlayImageView.tintColor = .black
        audioPlayImageView.isUserInteractionEnabled = true
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tappedPlayPauseButton))
        audioPlayImageView.addGestureRecognizer(tapGestureRecognizer)
        return audioPlayImageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .white
        
        contentView.addSubview(audioStackView)
        contentView.addSubview(audioImageView)
        contentView.addSubview(audioPlayImageView)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        audioImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(2)
            make.bottom.equalToSuperview().offset(-2)
            make.leading.equalToSuperview().offset(3)
            make.trailing.equalTo(audioStackView.snp.leading).offset(-5)
            make.width.equalTo(51)
            make.height.equalTo(51)
        }
        
        audioStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.bottom.equalToSuperview().offset(-5)
            make.leading.equalTo(audioImageView.snp.trailing).offset(5)
        }
        
        audioPlayImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-10)
            make.width.equalTo(18)
            make.height.equalTo(18)
        }
    }
    
    @objc
    func tappedPlayPauseButton() {
        guard let viewModel = viewModel else { return }
        delegate?.play(viewModel.model)
        configure(with: viewModel)
    }
}

extension AudioTableViewCell {
    func configure(with viewModel: AudioViewModel) {
        self.viewModel = viewModel
                
        audioTitle.text = viewModel.model.title
        audioArtist.text = viewModel.model.artist
        audioImageView.image = UIImage(named: viewModel.model.image)
        
        let image = viewModel.isNowPlaying ? UIImage(systemName: "stop.fill") : UIImage(systemName: "play.fill")
        audioPlayImageView.image = image
    }
}
