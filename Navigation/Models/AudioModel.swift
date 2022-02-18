//
//  AudioModel.swift
//  Navigation
//
//  Created by a.agataev on 17.02.2022.
//

import Foundation

final class AudioModel {
    let title: String
    let type: String
    let artist: String
    let image: String
    var isPlaying: Bool = false
    
    init(title: String, type: String, artist: String, image: String) {
        self.title = title
        self.type = type
        self.artist = artist
        self.image = image
    }
}
