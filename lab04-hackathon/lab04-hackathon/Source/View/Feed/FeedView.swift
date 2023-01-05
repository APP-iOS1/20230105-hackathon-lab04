//
//  FeedView.swift
//  lab04-hackathon
//
//  Created by MacBook on 2023/01/05.
//

import SwiftUI

struct FeedView: View {
    @State private var showMenu = false
    
    var body: some View {
        NavigationView {
            let drag = DragGesture()
                .onEnded {
                    if $0.translation.width < -100 {
                        withAnimation {
                            showMenu = false
                        }
                    }
                }
            
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    ScrollView {
                        // 제목
                        HStack {
                            Text("햄뿡이")
                                .font(.largeTitle)
                                .padding(EdgeInsets(top: 5, leading: 5, bottom: -5, trailing: 0))
                            Spacer()
                        }
                        // 사진
                        Rectangle()
                            .fill(.gray)
                            .frame(width: Screen.maxWidth, height: Screen.maxWidth)
                        Group {
                            HStack {
                                // 하트
                                Group {
                                    Image(systemName: "heart")
                                    Text("1234")
                                }
                                
                                // 댓글
                                Group {
                                    Image(systemName: "message")
                                    Text("12")
                                }
                                Spacer()
                                Text("1월 4일")
                            }
                            // 피드 Description
                            HStack {
                                Text("햄뿡이에욧 !")
                                Spacer()
                            }
                            // 댓글
                            HStack {
                                // 프로필
                                Group {
                                    Image(systemName: "person.circle.fill")
                                    Text("주희 :").offset(x: -5)
                                    Text("햄뿡이 기여워").offset(x: -5)
                                }
                                Spacer()
                                Text("댓글 모두 보기")
                                    .opacity(0.5)
                            }
                        }.padding([.leading, .trailing], 3)
                        Divider()
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
                        Image(systemName: "line.3.horizontal")
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        print("hi")
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}
