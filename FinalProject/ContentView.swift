//
//  ContentView.swift
//  FinalProject
//
//  Created by Luke Kuhara on 2021/6/2.
//

import SwiftUI

struct ContentView: View {
    @State var showMenu = false
    @EnvironmentObject var acvm : accountvm
    @State var refreshControl = UIRefreshControl()
    @ObservedObject var avm = articlevm()
   
    private func item() -> some View{
        return Group{
            if self.acvm.issignin{
              NavigationLink(
                destination: createarticle(nickname: acvm.session!.displayname),
                    label: {
                        Image(systemName: "plus")
                    })
            }
            else{
            NavigationLink(
                destination: loginview(),
                    label: {
                        Image(systemName: "plus")
                    })
            }
            
        
    }
    }
    
    var body: some View {
        let drag = DragGesture()
                    .onEnded {
                        if $0.translation.width < -100 {
                            withAnimation {
                                self.showMenu = false
                            }
                        }
                    }
        return NavigationView {
            GeometryReader { geometry in
                ZStack(alignment:.leading){
                   

                    
                    RefreshScrollview(showMenu: self.$showMenu,refreshControl: self.$refreshControl)
                                        .frame(width: geometry.size.width, height: geometry.size.height)
                                        .offset(x: self.showMenu ? geometry.size.width/2 : 0)
                                        .disabled(self.showMenu ? true : false)
                    
                    
                             
                        
                    
                   
                    if self.showMenu{
                        sidemenu()
                            .frame(width: geometry.size.width/1.5, alignment: .leading)
                            .transition(.move(edge: .leading))
                        
                    }

                }
                .gesture(drag)
            }
            .navigationBarTitle("ios forum 1.0", displayMode: .inline)
            .navigationBarItems(leading: (
                                Button(action: {
                                    withAnimation {
                                        self.showMenu.toggle()
                                    }
                                }) {
                                    Image(systemName: "line.horizontal.3")
                                        .imageScale(.large)
                                }
                            ),
            trailing: (
                item()
                )
            
            
            )
            
            
}
        .onAppear{
            self.avm.getarticle()
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

