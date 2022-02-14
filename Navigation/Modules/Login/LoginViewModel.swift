//
//  LoginViewModel.swift
//  Navigation
//
//  Created by Азамат Агатаев on 30.01.2022.
//

import Foundation

class LoginViewModel {
    
    private(set) var state: State = .initial {
        didSet {
           onStateChanged?(state)
        }
    }
    
    var onStateChanged: ((State) -> Void)?
    var showProfileVc: ((String) -> Void)?

    func send(_ action: Action){
        switch action {
        case .showProfileVc(let title):
            showProfileVc?(title)
        }
    }
}

extension LoginViewModel {
    enum Action {
        case showProfileVc(String)
    }

    enum State {
        case initial
        case configureKeyboards
        case error(String)
    }
}
