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
    private let viewModel: ProfileViewModel
    
    private var service: UserService
    private var fullName: String
    
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
    
    init(viewModel: ProfileViewModel, service: UserService, fullName: String) {
        self.viewModel = viewModel
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
        
        
        setupView()
        setupLayout()
        
        configureProfileHeaderView()
        setupTableView()
        
        profileHeaderView.delegate = self
        
        setupViewModel()
        viewModel.send(.viewIsReady)
    }
    
    private func setupView() {
        #if DEBUG
            view.backgroundColor = .red
        #else
            view.backgroundColor = .blue
        #endif
        
        navigationItem.hidesBackButton = true
        navigationItem.title = .profileTitle
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Sign Out", style: .plain, target: self, action: #selector(signOutTapped))

        view.addSubview(tableView)
    }
    
    private func setupTableView() {
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
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        sizeHeaderToFit(tableView)
    }
    
    private func sizeHeaderToFit(_ tableView: UITableView) {
        
        guard let headerView = tableView.tableHeaderView else {
            return
        }
        let size = headerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)

        headerView.frame.size = size
        tableView.tableHeaderView = headerView
    }
    
    deinit {
        viewModel.cancelTimer()
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
        do {
            let user = try service.getUser(fullName: fullName)
            profileHeaderView.configure(with: user)
        } catch let error as UserNotFoundError {
            showAlertUserNotFound(with: error)
        } catch {
            print("Counldn't create the user")
        }
    }
    
    private func setupViewModel() {
        viewModel.onStateChanged = { [weak self] state in
            guard let self = self else { return }
            switch state {
            case .initial:
                print("initial")
            case .loaded:
                self.tableView.reloadData()
                self.viewModel.createTimer()
            case .updateCell:
                self.updateCell()
            case .presentNewsAlert:
                self.presentNewsAlert()
            case .alertEmptyData(let error):
                self.showAlertEmptyPosts(with: error)
            }
        }
    }
    
    @objc
    func signOutTapped() {
        LoginInspector.signOut()
        viewModel.send(.showLoginVc)
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
            return viewModel.posts.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: .photosTableId, for: indexPath) as? PhotosTableViewCell else { preconditionFailure("Unable to cast cell to PhotosTableViewCell") }
            cell.photosFirstImageView.image = UIImage(named: photos[0].imageNamed)
            cell.photosSecondImageView.image = UIImage(named: photos[1].imageNamed)
            cell.photosThirdImageView.image = UIImage(named: photos[2].imageNamed)
            cell.photosFourthImageView.image = UIImage(named: photos[3].imageNamed)
            return cell
        case 1:
            guard let cell = self.tableView.dequeueReusableCell(withIdentifier: .timerTableId, for: indexPath) as? TimerTableViewCell else { preconditionFailure("Unable to cast cell to TimerTableViewCell") }
            cell.titleLabel.text = "Осташееся время обновления: \(viewModel.reverseTime)"
            return cell

        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: .postTableId, for: indexPath) as? PostTableViewCell else { fatalError() }
            let currentPost: Post = viewModel.posts[indexPath.row]
            cell.configure(with: currentPost)
            
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            viewModel.send(.showPhotosVc)
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

//MARK: - setup update timer and present alert
extension ProfileViewController {
    
    func updateCell() {
        let indexPath = IndexPath(row: 0, section: 1)
        if let cell = tableView.cellForRow(at: indexPath) as? TimerTableViewCell {
            cell.titleLabel.text = "Осташееся время обновления: \(viewModel.reverseTime)"
        } else { preconditionFailure("Unable to cast cell to TimerTableViewCell") }
        tableView.reloadRows(at: [indexPath], with: .none)
    }
    
    func presentNewsAlert() {
        let alertVC = UIAlertController(title: "Свежая новость", message: "Показать новость?", preferredStyle: .alert)
        let yes = UIAlertAction(title: "Да", style: .default) { _ in
            self.viewModel.createTimer()
            self.tableView.reloadData()
        }
        let no = UIAlertAction(title: "Нет", style: .default) { _ in
            self.viewModel.cancelTimer()
            self.tableView.reloadData()

        }
        
        alertVC.addAction(yes)
        alertVC.addAction(no)
        
        self.present(alertVC, animated: true, completion: nil)
    }
}

extension ProfileViewController {
        
    private func showAlertEmptyPosts(with error: EmptyDataError) {
        CommonAlertError.present(vc: self, with: error)
    }
    
    private func showAlertUserNotFound(with error: UserNotFoundError) {
        CommonAlertError.present(vc: self, with: error)
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
