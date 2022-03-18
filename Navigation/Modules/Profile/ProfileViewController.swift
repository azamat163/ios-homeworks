//
//  ProfileViewController.swift
//  Navigation
//
//  Created by a.agataev on 11.10.2021.
//

import UIKit
import StorageService

protocol ProfileViewControllerDelegate: AnyObject {
    func onTappedAvatarImage(_ sender: UITapGestureRecognizer)
}

class ProfileViewController: UIViewController {
    
    private var posts = PostAPI.getPosts()
    private let photos = PhotosAPI.getPhotos()
    var showPhotosVc: (() -> Void)?
    
    var service: UserService
    var fullName: String
    var timer: Timer?
    var reverseTime: Int = 10
    
    private lazy var profileHeaderView: ProfileHeaderView = {
        profileHeaderView = ProfileHeaderView(frame: .zero)
        profileHeaderView.toAutoLayout()
    
        return profileHeaderView
    }()

    private lazy var tableView: UITableView = {
        tableView = UITableView(frame: .zero, style: .grouped)
        tableView.toAutoLayout()
        
        return tableView
    }()
    
    init(service: UserService, fullName: String) {
        self.service = service
        self.fullName = fullName
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
       
        profileHeaderView.backgroundColor = .lightGray
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        #if DEBUG
            view.backgroundColor = .red
        #else
            view.backgroundColor = .blue
        #endif

        navigationItem.hidesBackButton = true
        navigationItem.title = .profileTitle
        
        view.addSubview(tableView)
        
        setupLayout()
        
        configureProfileHeaderView()
        
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
        
        tableView.register(TimerTableViewCell.self, forCellReuseIdentifier: .timerTableId)
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: .postTableId)
        tableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: .photosTableId)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        
        tableView.reloadData()
        
        profileHeaderView.delegate = self
        
        createTimer()
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
    
    deinit {
        cancelTimer()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        createTimer()
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
    
    private func configureProfileHeaderView() {
        guard let user = service.getUser(fullName: fullName) else { return }
        profileHeaderView.configure(with: user)
    }
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        case 2:
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
            guard let cell = self.tableView.dequeueReusableCell(withIdentifier: .timerTableId, for: indexPath) as? TimerTableViewCell else { fatalError() }
            cell.titleLabel.text = "Осташееся время обновления: \(self.reverseTime)"
            return cell

        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: .postTableId, for: indexPath) as? PostTableViewCell else { fatalError() }
            let currentPost: Post = posts[indexPath.row]
            cell.configure(with: currentPost)
            
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            showPhotosVc?()
        }
    }
    
}

extension ProfileViewController: ProfileViewControllerDelegate {
    
    func onTappedAvatarImage(_ sender: UITapGestureRecognizer) {
        let avatarImageView = profileHeaderView.avatarImageView
        avatarImageView.isHidden = true
        let profileShadowView = ProfileShadowView(toView: avatarImageView, frame: .zero)
        profileShadowView.frame.size = view.frame.size
        view.addSubview(profileShadowView)
        
        profileShadowView.animationAvatarImage()
        profileShadowView.animationCloseButton()
    }
}

extension ProfileViewController {
    func createTimer() {
        if timer == nil {
            let timer = Timer.scheduledTimer(
                timeInterval: 1.0,
                target: self,
                selector: #selector(self.updateTimer),
                userInfo: nil,
                repeats: true
            )
            timer.tolerance = 0.1

            DispatchQueue.global().async {
                RunLoop.current.add(timer, forMode: .common)
                RunLoop.current.run()
            }
            self.timer = timer
        }
    }
    
    @objc func updateTimer() {
        if reverseTime > 0 {
            reverseTime -= 1
            DispatchQueue.main.async {
                self.updateCell()
            }
        } else {
            reverseTime = 10
            cancelTimer()
            posts.append(posts.randomElement()!)
            DispatchQueue.main.async {
                self.presentNewsAlert()
            }
        }
    }
    
    func cancelTimer() {
      timer?.invalidate()
      timer = nil
    }
    
    func updateCell() {
        let indexPath = IndexPath(row: 0, section: 1)
        if let cell = tableView.cellForRow(at: indexPath) as? TimerTableViewCell {
            cell.titleLabel.text = "Осташееся время обновления: \(reverseTime)"
        }
        tableView.reloadRows(at: [indexPath], with: .none)
    }
    
    func presentNewsAlert() {
        let alertVC = UIAlertController(title: "Свежая новость", message: "Показать новость?", preferredStyle: .alert)
        let yes = UIAlertAction(title: "Да", style: .default) { _ in
            self.createTimer()
            self.tableView.reloadData()
        }
        let no = UIAlertAction(title: "Нет", style: .default) { _ in
            self.cancelTimer()
            self.tableView.reloadData()

        }
        
        alertVC.addAction(yes)
        alertVC.addAction(no)
        
        self.present(alertVC, animated: true, completion: nil)
    }
}

private extension String {
    static let postTableId = "postTableId"
    static let photosTableId = "photosTableId"
    static let timerTableId = "timerTableId"
    static let profileTitle = "Profile"
}


private extension CGFloat {
    static let profileHeaderViewHeight: CGFloat = 220
}
