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




struct main_interface: View {
    
    @Binding var showMenu:Bool
    @ObservedObject var avm = articlevm()
    @ObservedObject var acvm = accountvm()
    @Binding var refreshControl : UIRefreshControl
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
        .onAppear{
            self.updatedata()
            NotificationCenter.default.addObserver(forName: NSNotification.Name("Update"), object: nil, queue: .main){
                (_) in print("update")
                DispatchQueue.main.asyncAfter(deadline: .now() + 1 ){
                    self.updatedata()
                    self.refreshControl.endRefreshing()
                }
            }
        }
        
 
    }
    
    func updatedata(){
        avm.getarticle()
        
    }
    
}


struct sheet1: View  {
   var aid: String
    var title: String
    var content: String
    var from: String
    @ObservedObject var avm : articlevm
    @EnvironmentObject var acvm : accountvm
  
    
    private func item() -> some View{
        return Group{
            if self.acvm.issignin{
            NavigationLink(
                destination: replyarticle(title: title, id: aid, from: acvm.session!.displayname),
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
    
    var body: some View{
       
            
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
 */
                    ForEach(avm.replys, id: \.id){ thread in
                        Text(thread.from)
                            .font(.system(size: 15))
                        Text(thread.content)
                            .font(.system(size: 32))
                       
                    }
                Spacer()
                }

                .onAppear(){
                    self.avm.getarticlereply(id: aid)
                }
        .navigationBarTitle(title)
        .navigationBarTitleDisplayMode(.inline)
                .navigationBarItems(trailing: item())
    }
}


struct createarticle: View{
    @ObservedObject var avm = articlevm()
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @State private var showAlert = false
    var nickname: String
    @State var title: String = ""
    @State var content: String = ""
    var body: some View{
        VStack(alignment:.leading){
            Text("Title:")
            TextField("title",text:$title)
            Text("Content:")
                .padding([.top],20)
            TextField("content",text:$content)
            Spacer()
        }
        .navigationBarItems(trailing: Button(action: {
            if avm.uploadarticle(title: title, content: content, nickname: nickname){
                showAlert = true
            }
        }){
            Image(systemName: "paperplane.fill")
        })
        .alert(isPresented: $showAlert){
            () -> Alert in
            return Alert(title: Text("Upload success"), dismissButton: .default(Text("OK"),action:{
                self.mode.wrappedValue.dismiss()
            } ))
        }
        
    }
    
}

struct  replyarticle: View {
    var title: String
    var id: String
    var from: String
    @State var content: String = ""
    @ObservedObject var avm = articlevm()
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @State private var showAlert = false
    var body: some View{
        VStack(alignment:.leading){
            Text("Content:")
            TextField("content",text:$content)
            Spacer()
        }
        .navigationBarTitle(Text(title))
        .navigationBarItems(trailing: Button(action:{
            if avm.uploadreply(id: id, content: content, from: from){
                showAlert = true
            }
            
        }){
            
            Image(systemName: "paperplane.fill")
           
            
        })
        .alert(isPresented: $showAlert){
            () -> Alert in
            return Alert(title: Text("reply success"), dismissButton: .default(Text("OK"),action:{
                self.mode.wrappedValue.dismiss()
            } ))
        }

    }
}


struct RefreshScrollview: UIViewRepresentable {
   
    func makeCoordinator() -> Coordinator {
        return RefreshScrollview.Coordinator()
    }
    
    @Binding var showMenu:Bool
    @Binding var refreshControl : UIRefreshControl
    @ObservedObject var avm = articlevm()
    func updateUIView(_ uiView: UIScrollView, context: Context) {
        uiView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: CGFloat(250*avm.articles.count)+CGFloat(15*avm.articles.count)+15)
        
        for i in 0..<uiView.subviews.count{
            uiView.subviews[i].frame = CGRect(x:0,y:0,width:UIScreen.main.bounds.width,height:CGFloat(250*avm.articles.count)+CGFloat(15*avm.articles.count)+15)
        }
    }
    
    func makeUIView(context: Context) -> UIScrollView {
        let view = UIScrollView()
        refreshControl.attributedTitle = NSAttributedString(string: "pull to refresh")
        refreshControl.addTarget(context.coordinator, action: #selector(context.coordinator.update), for: .valueChanged)
        view.showsVerticalScrollIndicator = false
        view.refreshControl = refreshControl
        
        let child = UIHostingController(rootView: main_interface(showMenu: self.$showMenu , refreshControl: self.$refreshControl))
        
        
        child.view.frame = CGRect(x:0,y:0,width:UIScreen.main.bounds.width,height:CGFloat(250*6)+CGFloat(15*6)+15)
        view.addSubview(child.view)
        
        return view
    }
    
    class Coordinator: NSObject{
        @objc func update(){
            NotificationCenter.default.post(name: NSNotification.Name("Update"), object: nil)
        }

    }
}
