//
//  loginview.swift
//  FinalProject
//
//  Created by Fung on 2021/6/17.
//

import SwiftUI

struct loginview: View {
    @State var email: String = ""
    @State var password: String = ""
    @EnvironmentObject var acvm : accountvm
    
    var body: some View{
       
        VStack{
        VStack(alignment:.leading){
            Text("Email")
            TextField("Email",text:$email)
            
            Text("password")
            TextField("password",text:$password)
            
            
        }
        .padding([.leading],30)
            NavigationLink(destination:ContentView()
                            .navigationBarHidden(true)
                            .navigationBarBackButtonHidden(true)
                            ,isActive: $acvm.issignin){
                Button(action: {
                    acvm.signin(email: email, password: password)
                }, label: {
                    Text("Login")
                })
            }
            
            HStack{
                Text("Still don't have account? ")
                NavigationLink(
                    destination: signupview()
                    ,
                    label: {
                        Text("Sign up")
                    })
            }
            
        }
        
        
    
}
}


