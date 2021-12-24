//
//  PostTableViewCell.swift
//  Navigation
//
//  Created by Азамат Агатаев on 06.11.2021.
//

import UIKit
import StorageService
import iOSIntPackage

final class PostTableViewCell: UITableViewCell {
    
    private lazy var postAuthorLabel: UILabel = {
        postAuthorLabel = UILabel(frame: .zero)
        postAuthorLabel.font = UIFont.boldSystemFont(ofSize: 20)
        postAuthorLabel.textColor = .black
        postAuthorLabel.numberOfLines = 2
        postAuthorLabel.toAutoLayout()
        
        return postAuthorLabel
    }()
    
    private lazy var postImageView: UIImageView = {
        postImageView = UIImageView(frame: .zero)
        postImageView.contentMode = .scaleAspectFit
        postImageView.backgroundColor = .black
        postImageView.toAutoLayout()
        
        return postImageView
    }()
    
    private lazy var postDescription: UILabel = {
        postDescription = UILabel(frame: .zero)
        postDescription.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        postDescription.textColor = .systemGray
        postDescription.numberOfLines = 0
        postDescription.toAutoLayout()
        
        return postDescription
    }()
    
    private lazy var postLikes: UILabel = {
        postLikes = UILabel(frame: .zero)
        postLikes.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        postLikes.textColor = .black
        postLikes.toAutoLayout()
        
        return postLikes
    }()
    
    private lazy var postViews: UILabel = {
        postViews = UILabel(frame: .zero)
        postViews.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        postViews.textColor = .black
        postViews.toAutoLayout()
        
        return postViews
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubviews([
            postAuthorLabel,
            postImageView,
            postDescription,
            postLikes,
            postViews
        ])
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            postAuthorLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: .padding),
            postAuthorLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: .padding),
            postAuthorLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -.padding),
            
            postImageView.topAnchor.constraint(equalTo: postAuthorLabel.bottomAnchor, constant: .padding),
            postImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            postImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            postImageView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            postImageView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            
            postDescription.topAnchor.constraint(equalTo: postImageView.bottomAnchor, constant: .padding),
            postDescription.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: .padding),
            postDescription.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -.padding),

            postLikes.topAnchor.constraint(equalTo: postDescription.bottomAnchor, constant: .padding),
            postLikes.leadingAnchor.constraint(equalTo: postDescription.leadingAnchor),
            postLikes.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -.padding),
            
            postViews.topAnchor.constraint(equalTo: postDescription.bottomAnchor, constant: .padding),
            postViews.trailingAnchor.constraint(equalTo: postDescription.trailingAnchor),
            postViews.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -.padding),
        ])
    }
}

extension PostTableViewCell {
    
    public func configure(with post: Post) {
        postAuthorLabel.text = post.author
        postDescription.text = post.description
        postLikes.text = "Likes: \(post.likes)"
        postViews.text = "Views: \(post.views)"
                
        randomFilterImage(with: post.image)
    }
    
    private func randomFilterImage(with namedImage: String) {
        let imageProcessor = ImageProcessor()
        
        guard let image = UIImage(named: namedImage) else { return }
        guard let filter = ColorFilter.allCases.randomElement() else { return }
        
        DispatchQueue.main.async {
            imageProcessor.processImage(
                sourceImage: image,
                filter: filter,
                completion: { image in
                    self.postImageView.image = image
                }
            )
        }
    }
}



private extension CGFloat {
    static let padding: CGFloat = 16
}
