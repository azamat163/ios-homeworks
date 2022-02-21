//
//  AudiosViewController.swift
//  Navigation
//
//  Created by a.agataev on 17.02.2022.
//

import UIKit
import SnapKit

protocol AudiosViewControllerDelegate: AnyObject {
    func play(_ model: AudioModel)
}

class AudiosViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        tableView = UITableView(frame: .zero, style: .grouped)
        return tableView
    }()
    
    private let viewModel: AudiosViewModel
    
    init(viewModel: AudiosViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupLayout()
        setupViewModel()
        viewModel.send(.viewIsReady)
    }
    
    private func setupView() {
        view.backgroundColor = .white
        view.addSubview(tableView)
                
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(AudioTableViewCell.self, forCellReuseIdentifier: AudioTableViewCell.identifier)
    }
    
    private func setupLayout() {
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
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
            case .stopped:
                self.tableView.reloadData()
            case .played:
                self.tableView.reloadData()
            }
        }
    }
}

extension AudiosViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.audios.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AudioTableViewCell.identifier, for: indexPath) as? AudioTableViewCell else {
            preconditionFailure("Unable to cast cell to AudioTableViewCell")
        }
        
        let audioModel = viewModel.audios[indexPath.row]
        let viewModel = AudioViewModel(model: audioModel)
        cell.configure(with: viewModel)
        cell.delegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Музыка"
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
}

extension AudiosViewController: UITableViewDelegate {}

extension AudiosViewController: AudiosViewControllerDelegate {
    func play(_ model: AudioModel) {
        viewModel.send(.tappedPlayPause(model))
    }
}
