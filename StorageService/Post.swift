//
//  Post.swift
//  Navigation
//
//  Created by a.agataev on 14.10.2021.
//

import Foundation

public struct Post {
    public let author: String
    public let image: String
    public let description: String
    public let likes: Int
    public let views: Int
    
    public init(author: String, image: String, description: String, likes: Int, views: Int) {
        self.author = author
        self.image = image
        self.description = description
        self.likes = likes
        self.views = views
    }
}
