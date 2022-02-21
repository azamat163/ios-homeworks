//
//  AudioViewModel.swift
//  Navigation
//
//  Created by a.agataev on 21.02.2022.
//

import Foundation

final class AudioViewModel {

    private let service = AudioPlayerService.shared
    private(set) var model: AudioModel
    var isNowPlaying: Bool {
        return service.isPlaying && service.audio == model
    }
    
    init(model: AudioModel) {
        self.model = model
    }
}
