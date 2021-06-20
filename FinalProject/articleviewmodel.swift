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
    
    
    func uploadarticle(title: String, content: String, nickname: String) -> Bool{
        var status: Bool = false
        let db = Firestore.firestore()
        let articles = article( title: title, from: nickname, content: content)
        do{
            let documentref = try db.collection("article").addDocument(from: articles)
            if documentref.documentID != nil || documentref.documentID == ""{
                status = true
            }
        }catch
        {
            status = false
            print(error)
        }
     return status
    }
    
    
    
    func uploadreply(id:String,content: String, from: String) -> Bool{
        var status: Bool = false
        let db = Firestore.firestore()
        let replys = articlereply( from: from, content: content)
        do{
            let documnetref = try db.collection("article").document(id).collection("reply").addDocument(from: replys)
            if documnetref.documentID != nil || documnetref.documentID == "" {
                status = true
            }
        }catch{
            status = false
            print(error)
        }
        return status
    }
    
    
}




