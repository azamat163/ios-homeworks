//
//  PhotosCollectionViewCell.swift
//  Navigation
//
//  Created by Азамат Агатаев on 13.11.2021.
//

import UIKit

protocol ReusableView: AnyObject {
    static var identifier: String { get }
}

final class PhotosCollectionViewCell: UICollectionViewCell {
    
    var photo: Photo? {
        didSet {
            guard let photo = photo else { return }
            photosImageView.image = UIImage(named: photo.imageNamed)
        }
    }
        
    private lazy var photosImageView: UIImageView = {
        photosImageView = UIImageView(frame: .zero)
        photosImageView.toAutoLayout()
        
        return photosImageView
    }()
    
    func configure(with image: UIImage) {
        photosImageView.image = image
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.addSubview(photosImageView)
        
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            photosImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            photosImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            photosImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            photosImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}

extension PhotosCollectionViewCell: ReusableView {
    static var identifier: String {
        return String(describing: self)
    }
}
