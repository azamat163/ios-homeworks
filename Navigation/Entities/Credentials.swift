//
//  Credentials.swift
//  Navigation
//
//  Created by a.agataev on 24.05.2022.
//

import Foundation
import RealmSwift

class Credentials: Object {
    @objc dynamic var email = ""
    @objc dynamic var password = ""
}
