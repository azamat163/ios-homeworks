//
//  ProfileViewController.swift
//  Navigation
//
//  Created by a.agataev on 11.10.2021.
//

import UIKit

class ProfileViewController: UIViewController {
        
    private let posts = PostAPI.getPosts()
    
    lazy var profileHeaderView: ProfileHeaderView = {
        profileHeaderView = ProfileHeaderView(frame: .zero)
        return profileHeaderView
    }()

    lazy var tableView: UITableView = {
        tableView = UITableView(frame: .zero, style: .plain)
        return tableView
    }()
    
    override func loadView() {
        super.loadView()
       
        profileHeaderView.backgroundColor = .lightGray
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
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

}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: .postTableId, for: indexPath) as? PostTableViewCell else { fatalError() }
        let currentPost: Post = posts[indexPath.row]
        
        cell.postAuthorLabel.text = currentPost.author
        cell.postImageView.image = UIImage(named: currentPost.image)
        cell.postDescription.text = currentPost.description
        cell.postLikes.text = "Likes: \(currentPost.likes)"
        cell.postViews.text = "Views: \(currentPost.views)"
        
        return cell
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableView.automaticDimension
//    }
//
//    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableView.automaticDimension
//    }
}

private extension String {
    static let postTableId = "postTableId"
}


private extension CGFloat {
    static let profileHeaderViewHeight: CGFloat = 220
}
