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
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @State var signupstate: Bool = false
    @State private var showAlert = false
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
            Button(action: {
                
                acvm.signup(email: email, password: password, nickname: nickename)
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
               if acvm.issignupfin(fin: acvm.signupisfinish){
                showAlert = true
               }else{
                print("sign up thread fail")
               }
                }
            }, label: {
                Text("Button")
            })
            .alert(isPresented: $showAlert){
                () -> Alert in
                if acvm.signupstatus {
                    return Alert(title: Text("Create account Success"),dismissButton: .default(Text("OK"),action:{
                        self.mode.wrappedValue.dismiss()
                    }))
                }else{
                    return Alert(title: Text("Fail to create account"))
                }
            }
            
        }
        
    }
}

