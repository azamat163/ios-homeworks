//
//  AudioPlayerService.swift
//  Navigation
//
//  Created by a.agataev on 18.02.2022.
//

import Foundation
import AVFoundation

final class AudioPlayerService {
    static let shared = AudioPlayerService()
    var player: AVAudioPlayer?
    
    private init() {}
    
    func prepare(with audio: AudioModel) {
        do {
            guard let path = Bundle.main.path(forResource: audio.title, ofType: audio.type) else { return }
            player = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: path))
        } catch {
            print(error)
        }
    }
    
    func play(audio: AudioModel) {
        prepare(with: audio)
        player?.play()
    }
    
    func stop(audio: AudioModel) {
        prepare(with: audio)
        guard let player = player else {
            return
        }

        if player.isPlaying {
            player.stop()
        } else {
            print("Already stopped!")
        }
    }
}
