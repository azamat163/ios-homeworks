//
//  RealmService.swift
//  Navigation
//
//  Created by a.agataev on 24.05.2022.
//

import Foundation
import RealmSwift

final class RealmService: AuthService {
    private let ud = UserDefaults.standard
    private let realm = try! Realm()
    lazy var credentials: Results<Credentials> = { self.realm.objects(Credentials.self) }()
    
    func login(email: String, password: String, completion: @escaping Handler) {
        guard let credential = credentials.filter({ $0.email == email }).first else {
            createUser(email: email, password: password, completion: completion)
            return
        }
        signIn(email: credential.email, password: credential.password, completion: completion)
    }
    
    func createUser(email: String, password: String, completion: @escaping Handler) {
        try! realm.write({
            let newCredentials = Credentials()
            newCredentials.email = email
            newCredentials.password = password
            
            realm.add(newCredentials)
        })
        
        credentials = realm.objects(Credentials.self)
        
        completion(.success("\(String(describing: email)) created"))
    }
    
    func signIn(email: String, password: String, completion: @escaping Handler) {
        let userInfo = ["email": email, "password": password]
        ud.set(userInfo, forKey: "login_user")
        completion(.success("Login was \(String(describing: email))"))
    }
    
    func signOut() {
        ud.removeObject(forKey: "login_user")
        print("Delete user from UserDefaults")
        try! realm.write({
            realm.delete(realm.objects(Credentials.self))
        })
    }
}
