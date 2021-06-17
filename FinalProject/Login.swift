//
//  Login.swift
//  FinalProject
//
//  Created by Fung on 2021/6/17.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

struct User {
    var uid: String
    var email: String
    var displayname: String
    
    init(uid: String, email: String, displayname: String) {
        self.uid = uid
        self.email = email
        self.displayname = displayname
    }
}
