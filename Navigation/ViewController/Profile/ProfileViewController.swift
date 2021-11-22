//
//  ProfileViewController.swift
//  Navigation
//
//  Created by a.agataev on 11.10.2021.
//

import UIKit

class ProfileViewController: UIViewController {
    
    private let posts = PostAPI.getPosts()
    private let photos = PhotosAPI.getPhotos()
    
    lazy var profileHeaderView: ProfileHeaderView = {
        profileHeaderView = ProfileHeaderView(frame: .zero)
        profileHeaderView.toAutoLayout()
    
        return profileHeaderView
    }()

    lazy var tableView: UITableView = {
        tableView = UITableView(frame: .zero, style: .grouped)
        tableView.toAutoLayout()
        
        return tableView
    }()
    
    override func loadView() {
        super.loadView()
       
        profileHeaderView.backgroundColor = .lightGray
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.hidesBackButton = true
        navigationItem.title = .profileTitle
        
        view.addSubview(tableView)
        
        profileHeaderView.toAutoLayout()
        tableView.toAutoLayout()
        
        setupLayout()
        
        tableView.tableHeaderView = profileHeaderView
        
        let widthConstraint = NSLayoutConstraint(
            item: profileHeaderView,
            attribute: .width,
            relatedBy: .equal,
            toItem: tableView,
            attribute: .width,
            multiplier: 1,
            constant: 0)
        
        tableView.addConstraint(widthConstraint)
        
        profileHeaderView.layoutIfNeeded()
        
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: .postTableId)
        tableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: .photosTableId)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        
        tableView.reloadData()
        
        setupTapGestureRecognizer()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        sizeHeaderToFit(tableView)
    }
    
    func sizeHeaderToFit(_ tableView: UITableView) {
        
        guard let headerView = tableView.tableHeaderView else {
            return
        }
        let size = headerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)

        headerView.frame.size = size
        tableView.tableHeaderView = headerView
    }
    
    //MARK: - setup tableView layout
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            profileHeaderView.heightAnchor.constraint(equalToConstant: .profileHeaderViewHeight),
            
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setupTapGestureRecognizer() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(onTappedAvatarImage(_:)))
        profileHeaderView.avatarImageView.addGestureRecognizer(tapGestureRecognizer)
    }
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return posts.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: .photosTableId, for: indexPath) as? PhotosTableViewCell else { fatalError() }
            cell.photosFirstImageView.image = UIImage(named: photos[0].imageNamed)
            cell.photosSecondImageView.image = UIImage(named: photos[1].imageNamed)
            cell.photosThirdImageView.image = UIImage(named: photos[2].imageNamed)
            cell.photosFourthImageView.image = UIImage(named: photos[3].imageNamed)
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: .postTableId, for: indexPath) as? PostTableViewCell else { fatalError() }
            let currentPost: Post = posts[indexPath.row]
            cell.postAuthorLabel.text = currentPost.author
            cell.postImageView.image = UIImage(named: currentPost.image)
            cell.postDescription.text = currentPost.description
            cell.postLikes.text = "Likes: \(currentPost.likes)"
            cell.postViews.text = "Views: \(currentPost.views)"
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            let photoVc = PhotosViewController()
            self.navigationController?.pushViewController(photoVc, animated: true)
        }
    }
    
}

extension ProfileViewController {
    
    @objc func onTappedAvatarImage(_ sender: UITapGestureRecognizer) {
        setupProfileShadowView(sender)
    }
    
    private func setupProfileShadowView(_ sender: UITapGestureRecognizer) {
        guard let avatarImage = sender.view else { return }
        avatarImage.isHidden = true
        let profileShadowView = ProfileShadowView(frame: .zero)
        profileShadowView.frame.size = view.frame.size
        view.addSubview(profileShadowView)
        profileShadowView.avatarImageView.frame = avatarImage.convert(avatarImage.bounds, to: view)
        
        animateAvatarImage(with: profileShadowView)
        animatedClosedButton(view: profileShadowView, avatarView: avatarImage)
    }
        
    private func animateAvatarImage(with view: ProfileShadowView) {
        UIView.animate(withDuration: 0.5, delay: 0, options: [.allowUserInteraction, .beginFromCurrentState, .allowUserInteraction], animations: { [unowned view] in
            view.avatarImageView.frame.size.width = view.bounds.width
            view.avatarImageView.frame.size.height = view.bounds.width
            view.avatarImageView.center = view.center
            view.avatarImageView.layer.cornerRadius = 0
            view.shadowView.alpha = 0.5
        })

        UIView.animate(withDuration: 0.3, delay: 0, options: [.curveLinear, .allowUserInteraction, .beginFromCurrentState], animations: { [unowned view] in
            view.closeButton.alpha = 1.0
        })
    }
    
    private func animatedClosedButton(view: ProfileShadowView, avatarView: UIView) {
        view.closeButton.addTarget(self, action: #selector(self.clickClosedButton(view:avatarView:)), for: .touchUpInside)
    }

    @objc func clickClosedButton(view: ProfileShadowView, avatarView: UIView) {
        UIView.animate(withDuration: 0.5, delay: 0, options: [.allowUserInteraction, .beginFromCurrentState, .allowUserInteraction], animations: { [unowned view] in
            view.avatarImageView.isHidden = true
        })
    }
}

private extension String {
    static let postTableId = "postTableId"
    static let photosTableId = "photosTableId"
    static let profileTitle = "Profile"
}


private extension CGFloat {
    static let profileHeaderViewHeight: CGFloat = 220
}
