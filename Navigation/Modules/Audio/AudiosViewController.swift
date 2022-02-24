//
//  AudiosViewController.swift
//  Navigation
//
//  Created by a.agataev on 17.02.2022.
//

import UIKit
import SnapKit
import AVKit

protocol AudiosViewControllerDelegate: AnyObject {
    func play(_ model: AudioModel)
    func playPrev(_ model: AudioModel)
    func playNext(_ model: AudioModel)
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
        tableView.register(VideosTableViewCell.self, forCellReuseIdentifier: VideosTableViewCell.identifier)
        tableView.register(RecordButtonTableViewCell.self, forCellReuseIdentifier: RecordButtonTableViewCell.identifier)
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
            case .playNext:
                self.tableView.reloadData()
            case .playPrev:
                self.tableView.reloadData()
            }
        }
    }
}

extension AudiosViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return viewModel.audios.count
        } else if section == 1 {
            return viewModel.videos.count
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: AudioTableViewCell.identifier, for: indexPath) as? AudioTableViewCell else {
                preconditionFailure("Unable to cast cell to AudioTableViewCell")
            }
            
            let audioModel = viewModel.audios[indexPath.row]
            let viewModel = AudioViewModel(model: audioModel, service: viewModel.service)
            cell.configure(with: viewModel)
            cell.delegate = self
            return cell
        } else if indexPath.section == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: VideosTableViewCell.identifier, for: indexPath) as? VideosTableViewCell else {
                preconditionFailure("Unable to cast cell to VideosTableViewCell")
            }
            
            let videoModel = viewModel.videos[indexPath.row]
            let viewModel = VideoViewModel(model: videoModel)
            cell.configure(with: viewModel)
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: RecordButtonTableViewCell.identifier, for: indexPath) as? RecordButtonTableViewCell else {
                preconditionFailure("Unable to cast cell to VideosTableViewCell")
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Музыка"
        } else if section == 1 {
            return "Видеo"
        } else {
            return ""
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 55
        } else {
            return UITableView.automaticDimension
        }
    }
}

extension AudiosViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            let videoModel = viewModel.videos[indexPath.row]
            guard let path = Bundle.main.path(forResource: videoModel.title, ofType: videoModel.type) else { return }
            let player = AVPlayer(url: URL.init(fileURLWithPath: path))
            let playerViewController = AVPlayerViewController()
            playerViewController.player = player
            present(playerViewController, animated: true) {
                player.play()
            }
        } else if indexPath.section == 2 {
            viewModel.send(.showRecordVc(self))
        }
    }
}

extension AudiosViewController: AudiosViewControllerDelegate {
    func play(_ model: AudioModel) {
        viewModel.send(.tappedPlayPause(model))
    }
    
    func playNext(_ model: AudioModel) {
        viewModel.send(.tappedNext(model))
    }
    
    func playPrev(_ model: AudioModel) {
        viewModel.send(.tappedPrev(model))
    }
}
