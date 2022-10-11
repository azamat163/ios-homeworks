//
//  PostFavoritesViewController.swift
//  Navigation
//
//  Created by a.agataev on 25.05.2022.
//

import UIKit
import SnapKit
import CoreData

class PostFavoritesViewController: UIViewController {
    private let viewModel: PostFavoritesViewModel
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: .postTableId)
        return tableView
    }()
    
    private lazy var emptyView: UIView = {
        let emptyView = UIView(frame: .zero)
        return emptyView
    }()
    
    private lazy var emptyTitleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "Список избранных постов пуст!"
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        return label
    }()
    
    private lazy var spinnerView: UIActivityIndicatorView = {
        spinnerView = UIActivityIndicatorView(style: .large)
        return spinnerView
    }()
    
    init(viewModel: PostFavoritesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Favorites Posts"
        
        view.backgroundColor = .clear
        view.addSubview(tableView)
        view.addSubview(spinnerView)
        
        emptyView.addSubview(emptyTitleLabel)
        view.addSubview(emptyView)

        setup()
        setupViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.send(.viewWillAppear)
    }
    
    private func setup() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        spinnerView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        emptyTitleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        emptyView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
    
    private func setupViewModel() {
        viewModel.onStateChanged = { [weak self] state in
            guard let self = self else { return }
            switch state {
            case .initial:
                self.hideContent()
                self.spinnerView.startAnimating()
            case .loading:
                self.hideContent()
                self.spinnerView.startAnimating()
            case .loaded:
                self.spinnerView.stopAnimating()
                self.showContent()
                self.tableView.reloadData()
            case .empty:
                self.spinnerView.stopAnimating()
            }
        }
    }
    
    private func showContent() {
        UIView.animate(withDuration: 0.25) {
            self.tableView.alpha = 1
            self.emptyView.alpha = 0
        }
    }
    
    private func hideContent() {
        UIView.animate(withDuration: 0.25) {
            self.tableView.alpha = 0
            self.emptyView.alpha = 1
        }
    }
}

extension PostFavoritesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: .postTableId) as? PostTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(with: viewModel.posts[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let post = viewModel.posts[indexPath.row]
            viewModel.send(.deleted(post))
        }
    }
}
