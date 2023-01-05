//
//  ContentView.swift
//  lab04-hackathon
//
//  Created by MacBook on 2023/01/05.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            PaintView().tabItem {
                Image(systemName: "house")
                Text("그림그리기")
            }.tag(1)
            AddFeedView().tabItem {
                Image(systemName: "house")
                Text("피드")
            }.tag(2)
            ProfileView().tabItem {
                Image(systemName: "house")
                Text("프로필")
            }.tag(2)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
