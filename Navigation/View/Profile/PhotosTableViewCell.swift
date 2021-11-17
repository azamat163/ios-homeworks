//
//  PhotosTableViewCell.swift
//  Navigation
//
//  Created by Азамат Агатаев on 13.11.2021.
//

import UIKit

class PhotosTableViewCell: UITableViewCell {
    
    lazy var photosTitleLabel: UILabel = {
        photosTitleLabel = UILabel(frame: .zero)
        photosTitleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        photosTitleLabel.text = .photosTitleText
        photosTitleLabel.textColor = .black
        photosTitleLabel.toAutoLayout()

        return photosTitleLabel
    }()

    lazy var photosRowImageView: UIImageView = {
        photosRowImageView = UIImageView(image: UIImage(systemName: "arrow.right"))
        photosRowImageView.tintColor = .black
        photosRowImageView.toAutoLayout()

        return photosRowImageView
    }()
    
    lazy var photosFirstImageView: UIImageView = {
        photosFirstImageView = UIImageView(frame: .zero)
        photosFirstImageView.clipsToBounds = true
        photosFirstImageView.layer.cornerRadius = .cornerRadius
        photosRowImageView.toAutoLayout()
        
        return photosFirstImageView
    }()
    
    lazy var photosSecondImageView: UIImageView = {
        photosSecondImageView = UIImageView(frame: .zero)
        photosSecondImageView.clipsToBounds = true
        photosSecondImageView.layer.cornerRadius = .cornerRadius
        photosRowImageView.toAutoLayout()
        
        return photosSecondImageView
    }()
    
    lazy var photosThirdImageView: UIImageView = {
        photosThirdImageView = UIImageView(frame: .zero)
        photosThirdImageView.clipsToBounds = true
        photosThirdImageView.layer.cornerRadius = .cornerRadius
        photosRowImageView.toAutoLayout()
        
        return photosThirdImageView
    }()
    
    lazy var photosFourthImageView: UIImageView = {
        photosFourthImageView = UIImageView(frame: .zero)
        photosFourthImageView.clipsToBounds = true
        photosFourthImageView.layer.cornerRadius = .cornerRadius
        photosRowImageView.toAutoLayout()
        
        return photosFourthImageView
    }()
    
    lazy var photosStackView: UIStackView = {
        photosStackView = UIStackView(
            arrangedSubviews: [
                photosFirstImageView,
                photosSecondImageView,
                photosThirdImageView,
                photosFourthImageView
            ]
        )
        photosStackView.axis = .horizontal
        photosStackView.spacing = .spacing
        photosStackView.distribution = .fillEqually
        photosStackView.toAutoLayout()
        
        return photosStackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubviews([
            photosTitleLabel,
            photosRowImageView,
            photosStackView
        ])
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            photosTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: .padding),
            photosTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: .padding),
            photosTitleLabel.bottomAnchor.constraint(equalTo: photosStackView.topAnchor, constant: -.padding),
            
            photosRowImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -.padding),
            photosRowImageView.centerYAnchor.constraint(equalTo: photosTitleLabel.centerYAnchor),
            
            photosStackView.topAnchor.constraint(equalTo: photosTitleLabel.bottomAnchor, constant: .padding),
            photosStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: .padding),
            photosStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -.padding),
            photosStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -.padding),
            
            photosFirstImageView.widthAnchor.constraint(lessThanOrEqualToConstant: amountImageWidth),
            photosFirstImageView.heightAnchor.constraint(lessThanOrEqualToConstant: amountImageWidth),
            
            photosSecondImageView.widthAnchor.constraint(lessThanOrEqualToConstant: amountImageWidth),
            photosSecondImageView.heightAnchor.constraint(lessThanOrEqualToConstant: amountImageWidth),

            
            photosThirdImageView.widthAnchor.constraint(lessThanOrEqualToConstant: amountImageWidth),
            photosThirdImageView.heightAnchor.constraint(lessThanOrEqualToConstant: amountImageWidth),

            
            photosFourthImageView.widthAnchor.constraint(lessThanOrEqualToConstant: amountImageWidth),
            photosFourthImageView.heightAnchor.constraint(lessThanOrEqualToConstant: amountImageWidth),
        ])
    }
    
    private var amountImageWidth: CGFloat {
        return CGFloat(round((UIScreen.main.bounds.width - (.padding * 2 + .spacing * 3)) / 4))
    }
}

private extension String {
    static let photosTitleText = "Photos"
}

private extension CGFloat {
    static let padding: CGFloat = 12
    static let spacing: CGFloat = 8
    static let cornerRadius: CGFloat = 6
}
