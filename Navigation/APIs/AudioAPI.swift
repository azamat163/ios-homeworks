//
//  AudioAPI.swift
//  Navigation
//
//  Created by a.agataev on 17.02.2022.
//

import Foundation

final class AudioAPI {
    
    func getAudios(_ completion: @escaping (Result<[AudioModel], Never>) -> Void) {
        completion(.success(Self.getStaticAudios()))
    }
    
    static func getStaticAudios() -> [AudioModel] {
        return [
            AudioModel(title: "Remember", type: "mp3", artist: "Becky Hill", image: "1"),
            AudioModel(title: "Before You Go", type: "mp3", artist: "Lewis Capaldi", image: "2"),
            AudioModel(title: "Iris", type: "mp3", artist: "Grace Davies", image: "3"),
            AudioModel(title: "2002", type: "mp3", artist: "Anne-Marie", image: "4"),
            AudioModel(title: "Little Bit of Love", type: "mp3", artist: "Tom Grennan", image: "5"),
        ]
    }
}
