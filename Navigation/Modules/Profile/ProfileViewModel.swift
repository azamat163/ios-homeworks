//
//  ProfileViewModel.swift
//  Navigation
//
//  Created by a.agataev on 14.02.2022.
//

import Foundation
import StorageService
import UIKit

final class ProfileViewModel {
    
    var onStateChanged: ((State) -> Void)?
    var showPhotosVc: (() -> Void)?
    var showLoginVc: (() -> Void)?
    
    private(set) var state: State = .initial {
        didSet {
            onStateChanged?(state)
        }
    }
    
    var posts = [Post]()
    private let postApi: PostAPI = PostAPI()
    private let coreDataService = CoreDataService()
    
    private var timer: Timer?
    var reverseTime: Int = 10
    
    func send(_ action: Action) {
        switch action {
        case .viewIsReady:
            fetchPosts()
        case .showPhotosVc:
            showPhotosVc?()
        case .showLoginVc:
            showLoginVc?()
        case .savePost(let post):
            coreDataService.save(post: post)
        }
    }
    
    private func fetchPosts() {
        postApi.fetchPosts { [weak self] result in
            switch result {
            case .success(let posts):
                self?.posts = posts
                DispatchQueue.main.async {
                    self?.state = .loaded
                }
            case .failure(let error):
                switch error {
                case .emptydata:
                    DispatchQueue.main.async {
                        self?.state = .alertEmptyData(error)
                    }
                }
            }
        }
    }
    
    func createTimer() {
        if timer == nil {
            let timer = Timer.scheduledTimer(
                timeInterval: 1.0,
                target: self,
                selector: #selector(self.updateTimer),
                userInfo: nil,
                repeats: true
            )
            timer.tolerance = 0.1

            DispatchQueue.global(qos: .userInitiated).async {
                RunLoop.current.add(timer, forMode: .common)
                RunLoop.current.run()
            }
            self.timer = timer
        }
    }
    
    @objc
    func updateTimer() {
        if reverseTime > 0 {
            reverseTime -= 1
            DispatchQueue.main.async {
                self.state = .updateCell
            }
        } else {
            reverseTime = 10
            cancelTimer()
            guard let post = posts.randomElement() else { return }
            posts.append(post)
            DispatchQueue.main.async {
                self.state = .presentNewsAlert
            }
        }
    }
    
    func cancelTimer() {
      timer?.invalidate()
      timer = nil
    }
}

extension ProfileViewModel {
    
    enum Action {
        case viewIsReady
        case showPhotosVc
        case showLoginVc
        case savePost(Post)
    }
    
    enum State {
        case initial
        case loaded
        case updateCell
        case presentNewsAlert
        case alertEmptyData(EmptyDataError)
    }
}
