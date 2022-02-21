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
        audioPlayImageView.image = UIImage(systemName: "play.circle.fill")
        audioPlayImageView.backgroundColor = .white
        audioPlayImageView.tintColor = .black
        audioPlayImageView.isUserInteractionEnabled = true
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tappedPlayPauseButton))
        audioPlayImageView.addGestureRecognizer(tapGestureRecognizer)
        return audioPlayImageView
    }()
    
    private lazy var audioBackwardImageView: UIImageView = {
        audioBackwardImageView = UIImageView(frame: .zero)
        audioBackwardImageView.image = UIImage(systemName: "backward.circle.fill")
        audioBackwardImageView.backgroundColor = .white
        audioBackwardImageView.tintColor = .black
        audioBackwardImageView.isUserInteractionEnabled = true
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tappedPrevButton))
        audioBackwardImageView.addGestureRecognizer(tapGestureRecognizer)
        return audioBackwardImageView
    }()
    
    private lazy var audioForwardImageView: UIImageView = {
        audioForwardImageView = UIImageView(frame: .zero)
        audioForwardImageView.image = UIImage(systemName: "forward.circle.fill")
        audioForwardImageView.backgroundColor = .white
        audioForwardImageView.tintColor = .black
        audioForwardImageView.isUserInteractionEnabled = true
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tappedNextButton))
        audioForwardImageView.addGestureRecognizer(tapGestureRecognizer)
        return audioForwardImageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .white
        
        contentView.addSubview(audioStackView)
        contentView.addSubview(audioImageView)
        contentView.addSubview(audioPlayImageView)
        contentView.addSubview(audioBackwardImageView)
        contentView.addSubview(audioForwardImageView)
        
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
            make.trailing.equalToSuperview().offset(-33)
            make.width.equalTo(30)
            make.height.equalTo(30)
        }
        
        audioBackwardImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-63)
            make.width.equalTo(30)
            make.height.equalTo(30)
        }
        
        audioForwardImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-3)
            make.width.equalTo(30)
            make.height.equalTo(30)
        }
    }
    
    @objc
    func tappedPlayPauseButton() {
        guard let viewModel = viewModel else { return }
        delegate?.play(viewModel.model)
        configure(with: viewModel)
    }
    
    @objc
    func tappedPrevButton() {
        guard let viewModel = viewModel else { return }
        delegate?.playPrev(viewModel.model)
        configure(with: viewModel)
    }
    
    @objc
    func tappedNextButton() {
        guard let viewModel = viewModel else { return }
        delegate?.playNext(viewModel.model)
        configure(with: viewModel)
    }
}

extension AudioTableViewCell {
    func configure(with viewModel: AudioViewModel) {
        self.viewModel = viewModel
                
        audioTitle.text = viewModel.model.title
        audioArtist.text = viewModel.model.artist
        audioImageView.image = UIImage(named: viewModel.model.image)
        
        let image = viewModel.isNowPlaying ? UIImage(systemName: "pause.circle.fill") : UIImage(systemName: "play.circle.fill")
        audioPlayImageView.image = image
    }
}
