//
//  LoginInspector.swift
//  Navigation
//
//  Created by Азамат Агатаев on 26.12.2021.
//

import Foundation
import FirebaseAuth

final class LoginInspector: LogInViewControllerCheckerDelegate {
    private let auth = Auth.auth()

    
    func signIn(inputLogin: String, inputPassword: String, completion: @escaping Handler) {
        let ud = UserDefaults.standard
        guard let user = auth.currentUser else {
            createUser(email: inputLogin, password: inputPassword, completion: completion)
            return
        }
        signIn(email: inputLogin, password: inputPassword, completion: completion)
        let userInfo = ["email": user.email, "password": inputPassword]
        ud.set(userInfo, forKey: user.uid)
    }
    
    private func createUser(email: String, password: String, completion: @escaping Handler) {
        auth.createUser(withEmail: email, password: password) { authResult, error in
            guard let user = authResult?.user else {
                print("\(email) already exists!")
                self.signIn(email: email, password: password, completion: completion)
                return
            }
            
            completion(.success("\(String(describing: user.email)) created"))
        }
    }
    
    private func signIn(email: String, password: String, completion: @escaping Handler) {
        auth.signIn(withEmail: email, password: password) { authResult, error in
            if let error = error,  let _ = AuthErrorCode(rawValue: error._code) {
                completion(.failure(error))
            } else {
                completion(.success("Login was \(String(describing: authResult?.user.email))"))
            }
        }
    }
}

extension LoginInspector {
    static func signOut() {
        do {
            try Auth.auth().signOut()
            print("Successfull logout!")
        } catch let error {
            print("\(error.localizedDescription)")
        }
    }
}
