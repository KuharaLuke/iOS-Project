//
//  main interface.swift
//  FinalProject
//
//  Created by Luke Kuhara on 2021/6/2.
//

import SwiftUI
import FirebaseFirestoreSwift
import Firebase

struct article:Codable, Identifiable {
    @DocumentID var id: String?
    let title: String
    let from: String
    let content: String
    
}

struct articlereply:Codable, Identifiable {
    @DocumentID var id: String?
    let from: String
    let content: String
    
}

struct Thread: Identifiable {
    let name: String
    let content: String
    let id = UUID()
}




/*
private var threads = [
    Thread(name: "NTUT",content:"Some words"),
    Thread(name: "WILL NOT",content:"Some words"),
    Thread(name: "GIVE",content:"Some words"),
    Thread(name: "STUDENTS",content:"Some words"),
    Thread(name: "A BREAK",content:"Some words")
]
*/
/*
struct main_interface: View {
    
    @Binding var showMenu:Bool
    
    var body: some View {
        List(threads) {
                Text($0.name)
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                Text($0.content)
                    .font(.body)
        }
    }
}
*/
struct main_interface: View {
    
    @Binding var showMenu:Bool
    @ObservedObject var avm = articlevm()
    var body: some View {
        
        List(avm.articles,id: \.id) {
                thread in
            NavigationLink(
                destination: sheet1(aid:thread.id ?? "",title:thread.title,content:thread.content,from: thread.from,avm: articlevm(id: thread.id ?? "")),
                label: {
                    VStack(alignment:.leading){
                    Text(thread.from)
                        .font(.system(size: 15))
                        
                    Text(thread.title)
                        .font(.system(size: 32))
                    
                    }
                    
                    
                })
        }
 
    }
}


struct sheet1: View  {
   var aid: String
    var title: String
    var content: String
    var from: String
    @ObservedObject var avm: articlevm
  
    
   
    
    var body: some View{
       
        NavigationView{
            
                VStack(alignment: .leading){
            
           
             Text(from)
                .font(.system(size: 15))
            Text(content)
                .font(.system(size: 32))
            
          /*
            List(avm.replys,id: \.id){
                thread in
                VStack(alignment:.leading){
                Text(thread.from)
                    .font(.system(size: 15))
                Text(thread.content)
                    .font(.system(size: 32))
                }
            }
 */
                    ForEach(avm.replys, id: \.id){ thread in
                        VStack(alignment:.leading){
                        Text(thread.from)
                            .font(.system(size: 15))
                        Text(thread.content)
                            .font(.system(size: 32))
                        }
                    }
                Spacer()
        }
            
        }
        
        
        .navigationBarTitle(title)
        .navigationBarTitleDisplayMode(.inline)
    }
}
