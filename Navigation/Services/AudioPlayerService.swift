//
//  AudioPlayerService.swift
//  Navigation
//
//  Created by a.agataev on 18.02.2022.
//

import Foundation
import AVKit

final class AudioPlayerService {
    static let shared = AudioPlayerService()
    
    private(set) var player: AVAudioPlayer?
    private(set) var audio: AudioModel?
    
    private init() {}
    
    var isPlaying: Bool {
        return player?.isPlaying ?? false
    }
    
    func play(with viewModel: AudioViewModel) {
        do {
            self.audio = viewModel.model
            guard let path = Bundle.main.path(forResource: viewModel.model.title, ofType: viewModel.model.type) else { return }
            player = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: path))
            play()
        } catch {
            print(error)
        }
    }
    
    func play() {
        player?.play()
    }
    
    func pause() {
        player?.pause()
    }
    
    func stop() {
        player?.stop()
    }
}
