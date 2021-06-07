//
//  sidemenu.swift
//  FinalProject
//
//  Created by Luke Kuhara on 2021/6/2.
//

import SwiftUI

struct sidemenu: View {
    var body: some View {
        GeometryReader{ geometry in
            ZStack{
                Color.black .ignoresSafeArea()
                HStack{
                    VStack(alignment: .leading, spacing: /*@START_MENU_TOKEN@*/nil/*@END_MENU_TOKEN@*/, content: {
                            Image(systemName: "person")
                                .foregroundColor(Color.gray)
                                .imageScale(.large)
                            .padding(.top,3)
                        VStack{
                            Image(systemName: "person")
                                .foregroundColor(Color.gray)
                                .imageScale(.large)
                                .padding(.top,geometry.size.height-200)
                            Image(systemName: "envelope")
                                .foregroundColor(Color.gray)
                                .imageScale(.large)
                            .padding(.top,10)
                            Image(systemName: "gear")
                                .foregroundColor(Color.gray)
                                .imageScale(.large)
                            .padding(.top,10)
                        }
                    })
                        .padding()
                        .frame(width:30,alignment: .leading)
                    Spacer()
                    VStack(alignment:.leading,spacing:nil,content:{
                            HStack{
                                Image(systemName:"magnifyingglass")
                                    .foregroundColor(Color.gray)
                                    .imageScale(.large)
                                Text("搜尋")
                                    .font(.title2)
                                    .foregroundColor(Color.white)
                            }
                                .padding(.top,20)
                            HStack{
                                Image(systemName:"person.3.fill")
                                    .foregroundColor(Color.gray)
                                    .imageScale(.large)
                                Text("追蹤中")
                                    .font(.title2)
                                    .foregroundColor(Color.white)
                                }
                                .padding(.top,3)
                        HStack{
                            Image(systemName:"backward.end.fill")
                                .foregroundColor(Color.gray)
                                .imageScale(.large)
                            Text("回帶")
                                .font(.title2)
                                .foregroundColor(Color.white)
                            }
                            .padding(.top,3)
                        HStack{
                            Image(systemName:"goforward.plus")
                                .foregroundColor(Color.gray)
                                .imageScale(.large)
                            Text("稍後觀看")
                                .font(.title2)
                                .foregroundColor(Color.white)
                            }
                            .padding(.top,3)
                        Spacer()
                    Text("休閒")
                        .font(.body)
                        .foregroundColor(Color.gray)
                    HStack{
                        Text("吹水台")
                            .font(.title3)
                            .foregroundColor(Color.white)
                        Text("體育台")
                            .font(.title3)
                            .foregroundColor(Color.white)
                            .padding(.leading,15)
                        }
                    Text("未知")
                        .font(.body)
                        .foregroundColor(Color.gray)
                        .padding(.top,10)
                    HStack{
                        Text("未定台")
                            .font(.title3)
                            .foregroundColor(Color.white)
                        Text("無梗台")
                            .font(.title3)
                            .foregroundColor(Color.white)
                            .padding(.leading,15)
                        }
                        
                    Spacer()
                    })
                    .frame(width:geometry.size.width/1.3,height:geometry.size.height,alignment:.trailing)
                    .padding(.trailing,20)
                }
            }
        }
    }
}

struct sidemenu_Previews: PreviewProvider {
    static var previews: some View {
        sidemenu()
    }
}
