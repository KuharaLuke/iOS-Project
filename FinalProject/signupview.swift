//
//  signupview.swift
//  FinalProject
//
//  Created by Fung on 2021/6/17.
//

import SwiftUI

struct signupview: View{
    @State var email: String = ""
    @State var password: String = ""
    @State var repassword: String = ""
    @State var nickename: String = ""
    @EnvironmentObject var acvm : accountvm
    @State var signupstate: Bool = false
    var body: some View{
        VStack{
        VStack(alignment:.leading){
            Text("Nickname")
            TextField("nickname",text:$nickename)
            Text("Email")
            TextField("Email",text:$email)
            Text("password")
            TextField("password",text:$password)
            Text("re-password")
            TextField("re-password",text:$repassword)
        }
        .padding([.leading],30)
            NavigationLink(destination:loginview()
                            .navigationBarHidden(true)
                            .navigationBarBackButtonHidden(true)
                           ,isActive: $acvm.signupstatus){
                Button(action: {
                 acvm.signup(email: email, password: password, nickname: nickename)
                   
                }, label: {
                    Text("Signup")
                })
            }
            
        }
        
    }
}

