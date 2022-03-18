//
//  VideoAPI.swift
//  Navigation
//
//  Created by a.agataev on 21.02.2022.
//

import Foundation

final class VideoAPI {
    
    func getVideos(_ completion: @escaping (Result<[VideoModel], Never>) -> Void) {
        completion(.success(Self.getStaticVideos()))
    }
    
    static func getStaticVideos() -> [VideoModel] {
        return [
            VideoModel(title: "Video1", type: "mp4"),
            VideoModel(title: "Video2", type: "mp4"),
            VideoModel(title: "Video3", type: "mp4"),
            VideoModel(title: "Video4", type: "mp4"),
            VideoModel(title: "Video5", type: "mp4"),
        ]
    }
}
