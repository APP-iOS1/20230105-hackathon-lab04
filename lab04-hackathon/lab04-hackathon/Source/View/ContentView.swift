//
//  ContentView.swift
//  lab04-hackathon
//
//  Created by MacBook on 2023/01/05.
//

import SwiftUI

struct ContentView: View {
    
    @State private var selectedTabBar: SelectedTab = .second
    
    var body: some View {
        ZStack {
            Color("background")
                .ignoresSafeArea()
            
            VStack {
                
                switch selectedTabBar {
                    
                case .first:
                    EmptyView()
                case .second:
                    EmptyView()
                case .third:
                    ProfileView()
                    
                }
                
                TabBarView(selectedTabBar: $selectedTabBar)
                    .frame(height: 50)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

