//
//  accountvm.swift
//  FinalProject
//
//  Created by Fung on 2021/6/17.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
import FirebaseAuth

class accountvm: ObservableObject{
    let auth = Auth.auth()
    @Published var issignin: Bool = false
    @Published var session: User?
    @Published var signupstatus: Bool = false
    @Published var signupisfinish: Bool = false
    
    
    
    
    
    
    func signin(email:String, password: String){
       auth.signIn(withEmail: email, password: password){
            result, error in
        if error != nil{
            print(error)
        }else{
            self.issignin = true
            //self.signupstatus = false
        }
        
        if let user = self.auth.currentUser{
            self.session = User(uid: user.uid ?? "", email: user.email ?? "", displayname: user.displayName ?? "")
        }else{
            return
        }
    }
    }
    
    
    func signup(email: String, password: String, nickname: String) {
            self.auth.createUser(withEmail: email, password: password){
           [weak self] result, error in
            guard let user = result?.user,
                  error == nil else{
                print(error?.localizedDescription)
                return
            }
                self?.signupstatus = true
                let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                changeRequest?.displayName = nickname
                changeRequest?.commitChanges(completion: { error in
                    guard error == nil else {
                           print(error?.localizedDescription)
                           return
                       }
                })
            
        
        }
        self.signupisfinish = true
    }
    
    
    func issignupfin(fin: Bool) -> Bool{
        return self.signupstatus
    }
    
    
    func signout(){
        do{
        try self.auth.signOut()
            self.session = nil
            self.issignin = false
        }catch{
        return
        }
        }
    }

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

