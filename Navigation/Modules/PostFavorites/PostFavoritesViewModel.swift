//
//  PostFavoritesViewModel.swift
//  Navigation
//
//  Created by a.agataev on 25.05.2022.
//

import Foundation
import StorageService

final class PostFavoritesViewModel {
    var onStateChanged: ((State) -> Void)?
    
    private(set) var state: State = .initial {
        didSet {
            onStateChanged?(state)
        }
    }

    private(set) var posts: [Post] = []
    private let coreDataService = CoreDataService()
    
    func send(_ action: PostFavoritesViewModel.Action) {
        switch action {
        case .viewWillAppear:
            state = .loading
            fetchPosts()
        }
    }
    
    private func fetchPosts() {
        self.posts = coreDataService.read()
        self.state = .loaded
    }
}

extension PostFavoritesViewModel {
    enum State {
        case initial
        case loading
        case loaded
    }
    enum Action {
        case viewWillAppear
    }
}
