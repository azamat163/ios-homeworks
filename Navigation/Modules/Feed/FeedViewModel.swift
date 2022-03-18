//
//  FeedViewModel.swift
//  Navigation
//
//  Created by Азамат Агатаев on 25.01.2022.
//

import Foundation

final class FeedViewModel {
    let model = FeedModel()
    var showPostVc: ((String) -> Void)?
    
    func send(_ action: Action){
        switch action {

        case .showPostVc(let title):
            showPostVc?(title)
        }
    }
}

extension FeedViewModel {
    enum Action {
        case showPostVc(String)
    }
}
