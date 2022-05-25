//
//  PostFavoritesViewController.swift
//  Navigation
//
//  Created by a.agataev on 25.05.2022.
//

import UIKit
import SnapKit

class PostFavoritesViewController: UIViewController {
    private let viewModel: PostFavoritesViewModel
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: .postTableId)
        return tableView
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

        view.backgroundColor = .red
        view.addSubview(tableView)
        view.addSubview(spinnerView)

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
            }
        }
    }
    
    private func showContent() {
        UIView.animate(withDuration: 0.25) {
            self.tableView.alpha = 1
        }
    }
    
    private func hideContent() {
        UIView.animate(withDuration: 0.25) {
            self.tableView.alpha = 0
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
}
