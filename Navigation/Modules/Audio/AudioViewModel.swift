//
//  AudioViewModel.swift
//  Navigation
//
//  Created by a.agataev on 21.02.2022.
//

import Foundation

protocol AudioViewModelProtocol {
    func isNowPlaying() -> Bool
}

final class AudioViewModel: AudioViewModelProtocol {
    private let service: AudioPlayerService
    var model: AudioModel
    
    init(model: AudioModel, service: AudioPlayerService) {
        self.model = model
        self.service = service
    }
    
    func isNowPlaying() -> Bool {
        return service.isPlaying && service.audio == model
    }
}
