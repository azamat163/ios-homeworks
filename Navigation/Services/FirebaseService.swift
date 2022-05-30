//
//  FirebaseService.swift
//  Navigation
//
//  Created by a.agataev on 24.05.2022.
//

import Foundation
import FirebaseAuth

final class FirebaseService: AuthService {
    private let auth = Auth.auth()
    private let ud = UserDefaults.standard
    
    func login(email: String, password: String, completion: @escaping Handler) {
        guard let user = auth.currentUser else {
            createUser(email: email, password: password, completion: completion)
            return
        }
        signIn(email: email, password: password, completion: completion)
        let userInfo = ["email": user.email, "password": password]
        ud.set(userInfo, forKey: "login_user")
    }
    
    func createUser(email: String, password: String, completion: @escaping Handler) {
        auth.createUser(withEmail: email, password: password) { authResult, error in
            guard let user = authResult?.user else {
                print("\(email) already exists!")
                self.signIn(email: email, password: password, completion: completion)
                return
            }
            
            completion(.success("\(String(describing: user.email)) created"))
        }
    }
    
    func signIn(email: String, password: String, completion: @escaping Handler) {
        auth.signIn(withEmail: email, password: password) { authResult, error in
            if let error = error,  let _ = AuthErrorCode(rawValue: error._code) {
                completion(.failure(error))
            } else {
                completion(.success("Login was \(String(describing: authResult?.user.email))"))
            }
        }
    }
    
    func signOut() {
        do {
            ud.removeObject(forKey: "login_user")
            print("Delete user from UserDefaults")
            try auth.signOut()
            print("Successfull logout!")
        } catch let error {
            print("\(error.localizedDescription)")
        }
    }
}
