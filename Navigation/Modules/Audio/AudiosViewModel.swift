//
//  AudiosViewModel.swift
//  Navigation
//
//  Created by a.agataev on 17.02.2022.
//

import Foundation

final class AudiosViewModel {
    
    var onStateChanged: ((State) -> Void)?
    
    private(set) var state: State = .initial {
        didSet {
            onStateChanged?(state)
        }
    }
    
    private(set) var audios = [AudioModel]()
    private let audioApi: AudioAPI = AudioAPI()
    private let service = AudioPlayerService.shared
    
    func send(_ action: AudiosViewModel.Action) {
        switch action {
        case .viewIsReady:
            fetchAudio()
        case .tappedPlayPause(let audioModel):
            let viewModel = AudioViewModel(model: audioModel)
            if viewModel.isNowPlaying {
                stop()
            } else {
                play(with: viewModel)
            }
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
    
    private func play(with viewModel: AudioViewModel) {
        service.play(with: viewModel)
        state = .played
    }
    
    private func stop() {
        service.stop()
        state = .stopped
    }
}

extension AudiosViewModel {
    
    enum Action {
        case viewIsReady
        case tappedPlayPause(AudioModel)
    }
    
    enum State {
        case initial
        case loaded
        case played
        case stopped
    }
}
