//
//  ProfileView.swift
//  lab04-hackathon
//
//  Created by MacBook on 2023/01/05.
//

import SwiftUI

struct ProfileView: View {
    
    private let columns: [GridItem] = [
        GridItem(.adaptive(minimum: 100))
    ]
    @EnvironmentObject var userVM : UserStore
    @EnvironmentObject var feed: FeedStore
    @EnvironmentObject var viewModel : AuthenticationViewModel
    
    @State private var writeContent : String = ""
    
    @State private var sheetShowing = false
    @State private var showingAlert = false
    
    var body: some View {
        
        ZStack {
            Color("background")
                .ignoresSafeArea()
            
            VStack {
                
                HStack {
                    Text(userVM.user.userName)
                        .font(.cafeTitle2)
                        .onAppear{
                            userVM.requestUserData()
                        }
                    Spacer()
                    
                    Button {
                        showingAlert.toggle()
                    } label: {
                        Image("logout")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20)
                    }
                    .alert("로그아웃", isPresented: $showingAlert) {
                        Button("확인") {
                            viewModel.signOut()
                            viewModel.authenticationState = .unauthenticated
                            viewModel.reset()
                            
                        }
                        Button("취소", role: .cancel) {}
                    } message: {
                        Text("로그아웃하시겠습니까?")
                    }
                }
                .padding()
                //자기소개
                VStack(alignment: .leading) {
                    if writeContent == ""{
                        Text("자기소개 해주세요")
                            .font(.cafeCaption2)
                            .frame(width: 340, height: 150, alignment: .leading)
                            .padding()
                    }else{
                        Text("\(writeContent)")
                            .font(.cafeCaption2)
                            .frame(width: 340, height: 150, alignment: .leading)
                            .padding()
                    }
                }
                .overlay (
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(lineWidth: 0.3)
                        .foregroundColor(.gray)
                )
                .overlay(
                    Button {
                        sheetShowing.toggle()
                    } label: {
                        Image("new")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20)
                    }
                        .padding(.top, 148)
                        .padding(.leading, 340)
                )
                
                VStack(alignment: .leading) {
                    
                    Text("내 캔버스")
                        .font(.cafeSubhead2)
                        .padding(.leading)
                        .padding(.top)
                    
                    ScrollView {
                        
                        // 데이터 연동 후 아무것도 없을때 조건 처리하기
                        LazyVGrid(columns: columns, spacing: 3) {
                            
                            ForEach(feed.feeds, id: \.self) { feed in
                                
                                NavigationLink {
                                    FeedCell(feed: feed)
                                } label: {
                                    if userVM.user.userId == feed.userId {
                                        Image(uiImage: feed.feedImage ?? UIImage())
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 127, height: 127)
                                            .overlay(
                                                Rectangle()
                                                    .stroke(Color.gray, lineWidth: 0.3)
                                            )
                                    }
                                }
                            }
                            .padding(.leading, 4)
                            .padding(.trailing, 4)
                        }
                    }
                }
                .frame(width: 390, height: 440)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(.clear)
                )
            }
            .sheet(isPresented: $sheetShowing) {
                ProfileSheetView(sheetShowing: $sheetShowing, writeContent: $writeContent)
                    .presentationDetents([.medium])
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView().environmentObject(UserStore()).environmentObject(FeedStore())
    }
}

