//
//  AudiosViewModel.swift
//  Navigation
//
//  Created by a.agataev on 17.02.2022.
//

import Foundation
import UIKit

final class AudiosViewModel {
    
    var onStateChanged: ((State) -> Void)?
    var showRecordVc: ((UIViewController) -> Void)?
    
    private(set) var state: State = .initial {
        didSet {
            onStateChanged?(state)
        }
    }
    
    private(set) var audios = [AudioModel]()
    private let audioApi: AudioAPI = AudioAPI()
    
    private(set) var videos = [VideoModel]()
    private let videoApi: VideoAPI = VideoAPI()
    
    private let service = AudioPlayerService.shared
    
    func send(_ action: AudiosViewModel.Action) {
        switch action {
        case .viewIsReady:
            fetchAudio()
            fetchVideo()
        case .tappedPlayPause(let audioModel):
            let viewModel = AudioViewModel(model: audioModel)
            playPause(with: viewModel)
        case .tappedPrev(let audioModel):
            let viewModel = AudioViewModel(model: audioModel)
            playPrev(with: viewModel)
        case .tappedNext(let audioModel):
            let viewModel = AudioViewModel(model: audioModel)
            playNext(with: viewModel)
        case .showRecordVc(let vc):
            showRecordVc?(vc)
        }
    }
    
    private func fetchAudio() {
        audioApi.getAudios { [weak self] result in
            switch result {
            case .success(let audios):
                self?.audios = audios
                self?.state = .loaded
            }
        }
    }
    
    private func fetchVideo() {
        videoApi.getVideos { [weak self] result in
            switch result {
            case .success(let videos):
                self?.videos = videos
                self?.state = .loaded
            }
        }
    }
    
    private func playPause(with viewModel: AudioViewModel) {
        if viewModel.isNowPlaying {
            stop()
        } else {
            play(with: viewModel)
        }
    }
    
    private func play(with viewModel: AudioViewModel) {
        service.play(with: viewModel)
        state = .played
    }
    
    private func stop() {
        service.stop()
        state = .stopped
    }
    
    private func playPrev(with viewModel: AudioViewModel) {
        var model: AudioModel?
        guard let index = audios.firstIndex(of: viewModel.model) else { return }
        if index == 0 {
            model = audios.last
        } else {
            model = audios[index - 1]
        }
        guard let model = model else { return }
        let preViewModel = AudioViewModel(model: model)
        playPause(with: preViewModel)
        state = .playPrev
    }
    
    private func playNext(with viewModel: AudioViewModel) {
        var model: AudioModel?
        guard let index = audios.firstIndex(of: viewModel.model) else { return }
        if index == audios.count - 1 {
            model = audios[0]
        } else {
            model = audios[index + 1]
        }
        guard let model = model else { return }
        let preViewModel = AudioViewModel(model: model)
        playPause(with: preViewModel)
        state = .playNext
    }
}

extension AudiosViewModel {
    
    enum Action {
        case viewIsReady
        case tappedPlayPause(AudioModel)
        case tappedPrev(AudioModel)
        case tappedNext(AudioModel)
        case showRecordVc(UIViewController)
    }
    
    enum State {
        case initial
        case loaded
        case played
        case stopped
        case playPrev
        case playNext
    }
}
