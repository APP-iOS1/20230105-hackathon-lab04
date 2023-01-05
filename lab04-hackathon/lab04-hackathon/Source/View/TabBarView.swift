//
//  TabBarView.swift
//  lab04-hackathon
//
//  Created by zooey on 2023/01/05.
//

import SwiftUI

enum SelectedTab {
    case first
    case second
    case third
}

struct TabBarView: View {
    
    @Binding var selectedTabBar: SelectedTab
    
    var body: some View {
        
        ZStack {
            Color("background")
                .ignoresSafeArea()
            HStack(spacing: 85) {
                
                Button {
                    selectedTabBar = .first
                } label: {
                    ZStack {
                        if selectedTabBar == .first {
                            Image("pen")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30)
                        } else {
                            Image("pen")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30)
                                .opacity(0.5)
                        }
                    }
                }
                
                Button {
                    selectedTabBar = .second
                } label: {
                    ZStack {
                        if selectedTabBar == .second {
                            Image("home")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30)
                        } else {
                            Image("home")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30)
                                .opacity(0.5)
                        }
                    }
                }
                
                Button {
                    selectedTabBar = .third
                } label: {
                    ZStack {
                        if selectedTabBar == .third {
                            Image("person")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30)
                        } else {
                            Image("person")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30)
                                .opacity(0.5)
                        }
                    }
                }
            }
        }
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView(selectedTabBar: .constant(.second))
    }
}

