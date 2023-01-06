//
//  ProfileView.swift
//  lab04-hackathon
//
//  Created by MacBook on 2023/01/05.
//

import SwiftUI

//struct DrawingItem: Identifiable {
//    var id = UUID()
//    var imageName: String
//}

struct ProfileView: View {
    
    private let columns: [GridItem] = [
        GridItem(.adaptive(minimum: 100))
    ]
    @EnvironmentObject var userVM : UserStore
    @EnvironmentObject var feed: FeedStore
    
    
//    @State private var drawingItem: [DrawingItem] = [
//        DrawingItem(imageName: "1"),
//        DrawingItem(imageName: "2"),
//        DrawingItem(imageName: "3"),
//        DrawingItem(imageName: "4"),
//        DrawingItem(imageName: "5"),
//        DrawingItem(imageName: "6"),
//        DrawingItem(imageName: "7"),
//        DrawingItem(imageName: "8"),
//        DrawingItem(imageName: "9")
//    ]
    // 내용을 입력해주세요 ( 자기소개 )?
    @State private var writeContent : String = ""
    @FocusState private var writeIsFocused: Bool
    
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
                        Button("확인") {print("로그아웃함")}
                        Button("취소", role: .cancel) {}
                    } message: {
                        Text("로그아웃하시겠습니까?")
                    }
                }
                .padding()
                //자기소개
                VStack {
                    Text("\(writeContent)")
                        .font(.cafeCaption2)
                        .frame(width: 340, height: 150, alignment: .leading)
                        .padding()
                        .focused($writeIsFocused)
                    
                }
                .overlay (
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(lineWidth: 0.3)
                        .foregroundColor(.gray)
                )
                .overlay(
                    
                    
                    Button {
                        sheetShowing.toggle()
                        // 자기소개 업데이트
                        //                        writeContent = userVM.updateUserDataIntroduce(content: writeContent)
                        // 텍스트필드에서 손 떼게
                        //                        writeIsFocused = false
                        
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
                                    Image(systemName: "plus")
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
                .frame(width: 390, height: 440)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(.clear)
                )
            }
            .sheet(isPresented: $sheetShowing) {
                ProfileSheetView(sheetShowing: $sheetShowing)
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

