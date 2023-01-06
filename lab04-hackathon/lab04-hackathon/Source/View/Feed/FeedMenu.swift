//
//  FeedMenu.swift
//  lab04-hackathon
//
//  Created by Park Jungwoo on 2023/01/05.
//

import SwiftUI

struct FeedMenu: View {
    @EnvironmentObject var feed: FeedStore
    @Binding var showingMenu: Bool
    var body: some View {
        
        VStack(alignment: .leading) {
            
            HStack {
                Button {
                    feed.feedsorted = feed.feeds
                    withAnimation {
                        showingMenu.toggle()
                    }

                } label: {
                    Image("folder")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20)
                    
                    Text("전체 게시물")
                        .font(.cafeHeadline2)
                }
                
            }.padding(.top, 100)
            
            HStack {
                Button {
                    feed.feedsorted = feed.feeds.filter{$0.category == "풍경"}
                    withAnimation {
                        showingMenu.toggle()
                    }
                } label: {
                    Image("folder")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20)
                    
                    Text("풍경 그림")
                        .font(.cafeHeadline2)
                }
                
            }.padding(.top, 30)
            
            HStack {
                Button {
                    feed.feedsorted = feed.feeds.filter{$0.category == "캐릭터"}
                    withAnimation {
                        showingMenu.toggle()
                    }
                } label: {
                    Image("folder")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20)
                    
                    Text("캐릭터 그림")
                        .font(.cafeHeadline2)
                }
                
            }.padding(.top, 30)
            
            HStack {
                Button {
                    feed.feedsorted = feed.feeds.filter{$0.category == "인물"}
                    withAnimation {
                        showingMenu.toggle()
                    }
                } label: {
                    Image("folder")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20)
                    
                    Text("인물 그림")
                        .font(.cafeHeadline2)
                }
                
            }.padding(.top, 30)
            
            HStack {
                Button {
                    feed.feedsorted = feed.feeds.filter{$0.category == "동물"}
                    withAnimation {
                        showingMenu.toggle()
                    }
                } label: {
                    Image("folder")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20)
                    
                    Text("동물 그림")
                        .font(.cafeHeadline2)
                }
            }.padding(.top, 30)
            Spacer()
        }
        .accentColor(.black)
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color("background"))
        .edgesIgnoringSafeArea(.all)
    }
}

struct FeedMenu_Previews: PreviewProvider {
    @State static var showingMenu = false
    static var previews: some View {
        FeedMenu(showingMenu: $showingMenu).environmentObject(FeedStore())
    }
}
