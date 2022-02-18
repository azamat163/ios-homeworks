//
//  AudioViewModel.swift
//  Navigation
//
//  Created by a.agataev on 17.02.2022.
//

import Foundation

final class AudioViewModel {
    
    var onStateChanged: ((State) -> Void)?
    
    private(set) var state: State = .initial {
        didSet {
            onStateChanged?(state)
        }
    }
    
    private(set) var audios = [AudioModel]()
    private let audioApi: AudioAPI = AudioAPI()
    private let audioService = AudioPlayerService.shared
    
    func send(_ action: AudioViewModel.Action) {
        switch action {
        case .viewIsReady:
            fetchAudio()
        case .tapAudioCell(let audio):
            guard let player = audioService.player else { return }
            if player.isPlaying {
                audioService.stop(audio: audio)
            } else {
                audioService.play(audio: audio)
                audio.isPlaying = true
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
}

extension AudioViewModel {
    
    enum Action {
        case viewIsReady
        case tapAudioCell(AudioModel)
    }
    
    enum State {
        case initial
        case loaded
    }
}
