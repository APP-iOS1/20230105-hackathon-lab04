//
//  FeedView.swift
//  lab04-hackathon
//
//  Created by MacBook on 2023/01/05.
//

import SwiftUI

struct FeedView: View {
    @State private var showMenu = false
    @EnvironmentObject var feed: FeedStore
    
    
    let data = Feed.dummy
    
    var body: some View {
        
        let drag = DragGesture()
            .onEnded {
                if $0.translation.width < -100 {
                    withAnimation {
                        showMenu = false
                    }
                }
            }
        
        ZStack {
            
            Color("background")
                .ignoresSafeArea()
            
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    ScrollView {
                        ForEach(feed.feeds, id: \.self) { feed in
                            FeedCell(feed: feed)
                        }
                    }
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .offset(x: showMenu ? geometry.size.width/2 : 0)
                    .disabled(showMenu ? true : false)
                    if showMenu {
                        FeedMenu()
                            .frame(width: geometry.size.width/2)
                            .transition(.move(edge: .leading))
                    }
                }
                .gesture(drag)
            }
            .toolbar {
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        withAnimation {
                            showMenu.toggle()
                        }
                    } label: {
                        Image("line")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20)
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink {
                        AddFeedView()
                    } label: {
                        Image("plus")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20)
                    }
                }
            }
        }
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView().environmentObject(FeedStore())
        
    }
}
