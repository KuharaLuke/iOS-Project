//
//  articleviewmodel.swift
//  FinalProject
//
//  Created by Fung on 2021/6/11.
//

import Foundation
import FirebaseFirestoreSwift
import Firebase

class articlevm: ObservableObject{
    @Published var articles = [article]()
    @Published var replys = [articlereply]()
   
    
    init(){
        getarticle()
    }
    
    init(id: String){
        getarticlereply(id: id)
    }
    
    func getarticle(){
        let db = Firestore.firestore()
        db.collection("article").getDocuments{
            querySnapshot, error in guard let snapshot = querySnapshot else { return }
            self.articles = snapshot.documents.compactMap { snapshot in
                try? snapshot.data(as: article.self)
                
                    }
        }
    }
    
    func getarticlereply(id: String) {
        
        let db = Firestore.firestore()
        db.collection("article").document(id).collection("reply").getDocuments{
            querySnapshot, error in guard let snapshot = querySnapshot else { return }
            self.replys = snapshot.documents.compactMap { snapshot in
                try? snapshot.data(as: articlereply.self)
                
                    }
            
        }
        
        
        
    }
    
    
}

