//
//  main interface.swift
//  FinalProject
//
//  Created by Luke Kuhara on 2021/6/2.
//

import SwiftUI

struct Thread: Identifiable {
    let name: String
    let content: String
    let id = UUID()
}
private var threads = [
    Thread(name: "NTUT",content:"Some words"),
    Thread(name: "WILL NOT",content:"Some words"),
    Thread(name: "GIVE",content:"Some words"),
    Thread(name: "STUDENTS",content:"Some words"),
    Thread(name: "A BREAK",content:"Some words")
]

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
