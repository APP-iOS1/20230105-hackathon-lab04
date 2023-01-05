//
//  AddfeedView.swift
//  hackathonPreview
//
//  Created by 장다영 on 2023/01/05.
//

import SwiftUI
import PhotosUI

struct AddFeedView: View {
    
    @EnvironmentObject var feedStore: FeedStore
    @EnvironmentObject var currentUser: UserStore
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var drawingCategory = ["캐릭터 그림", "인물 그림", "동물 그림", "풍경 그림"]
    @State private var currentCategory : String = "풍경 그림"
    @State private var index = 0
    @State private var drawingTitle = ""
    @State private var drawingDescription : String = ""
    @State private var placeHolder = "그림을 소개해주세요."
    @State private var selectedImage: PhotosPickerItem? = nil
    @State private var selectedImageData: Data? = nil
    var btnBack : some View { Button(action: {
        self.presentationMode.wrappedValue.dismiss()
    }) {
        
        Image("left")
            .resizable()
        //.scaledToFit()
        //.aspectRatio(contentMode: .fit)
            .frame(width:18, height: 18)// set image here
        
    }
    }
    
    var body: some View {
        ScrollView {
            VStack {
                Text("새 게시물")
                    .font(.cafeHeadline2)
                //MARK: - 사용자의 그림
                PhotosPicker(
                    selection: $selectedImage,
                    matching: .images,
                    photoLibrary: .shared()) {
                        if selectedImageData == nil {
                            Rectangle()
                                .foregroundColor(Color(red: 236/255, green: 232/255, blue: 221/255))
                                .frame(width:UIScreen.main.bounds.size.width, height:UIScreen.main.bounds.size.width)
                                .overlay(
                                    Image("imageChoice")
                                        .resizable()
                                    //.shadow(color: .white, radius: 5)
                                        .frame(width:UIScreen.main.bounds.size.width*0.6, height:UIScreen.main.bounds.size.width*0.6)
                                )
                        } else {
                            if let selectedImageData,
                               let uiImage = UIImage(data: selectedImageData) {
                                Image(uiImage: uiImage)
                                    .resizable()
                                    .frame(width:UIScreen.main.bounds.size.width, height:UIScreen.main.bounds.size.width)
                            }
                        }
                    }
                    .onChange(of: selectedImage) { newItem in
                        Task {
                            // Retrieve selected asset in the form of Data
                            if let data = try? await newItem?.loadTransferable(type: Data.self) {
                                selectedImageData = data
                            }
                        }
                    }
                
                
                // MARK: - 카테고리
                VStack {
                    HStack {
                        Text("카테고리")
                            .font(.cafeHeadline2)
                        Spacer()
                        // 카테고리 피커(메뉴)
                        Menu{
                            ForEach(Array(drawingCategory.enumerated()), id: \.offset){index, category in
                                Button(action: {
                                    self.index = index
                                    self.currentCategory = category
                                }, label: {
                                    HStack{
                                        Text(category)
                                        if currentCategory == drawingCategory[index]{
                                            Image(systemName: "checkmark")
                                        }
                                    }
                                })
                            }
                        } label: {
                            HStack {
                                Text(drawingCategory[index])
                                    .foregroundColor(.black)
                                    .font(.cafeHeadline2)
                                    .frame(width: UIScreen.main.bounds.width*0.25)
                                Image(systemName: "chevron.down")
                                    .foregroundColor(.black)
                            }
                            
                        }.animation(nil)
                    }

                }
                .padding([.leading, .trailing, .top])
                Divider()

                
                //MARK: - 제목입력
                VStack {
                    HStack {
                        Text("제목입력")
                            .font(.cafeHeadline2)
                        Spacer()
                    }
                    TextField(" 그림의 제목을 알려주세요.", text: $drawingTitle)
                        .font(.cafeHeadline2)
                    
                        .frame(width:UIScreen.main.bounds.size.width-40, height: 40)
                        .background(.white)
                        .overlay (
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(lineWidth: 0.3)
                                .foregroundColor(.gray)
                        )
                    
                }
                .padding([.leading, .trailing])
                Divider()
                    .padding(.top, 5)
                
                // MARK: - 문구 입력
                VStack {
                    HStack {
                        Text("문구입력")
                            .font(.cafeHeadline2)
                        Spacer()
                    }
                    //placeHolder를 위해 사용
                    if drawingDescription.isEmpty {
                        TextEditor(text: $placeHolder)
                            .font(.cafeHeadline2)
                            .foregroundColor(.black)
                            .opacity(0.2)
                            .overlay (
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(lineWidth: 0.3)
                                    .foregroundColor(.gray)
                            )
                            .background(.white)
                            .frame(width:UIScreen.main.bounds.size.width-40, height: 200)
                        
                    } else {
                        TextEditor(text: $drawingDescription)
                            .font(.cafeHeadline2)
                            .overlay (
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(lineWidth: 0.3)
                                    .foregroundColor(.gray)
                            )
                            .frame(width:UIScreen.main.bounds.size.width-40, height: 200)
                    }
                    
                    
                }
                .padding([.leading, .trailing])
                
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: btnBack)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    //let imageURL = UUID().uuidString
                    let feedId = UUID().uuidString
                    let currenTitle: String = drawingTitle
                    let currentDescription: String = drawingDescription
                    feedStore.uploadImage(image: selectedImageData, imageURL: "")
                    feedStore.create(Feed(feedId: feedId, userId: currentUser.user.userId, title: currenTitle, imageURL: "", description: currentDescription, category: currentCategory, userName: currentUser.currentUserName!, date: Date.now))
                } label: {
                    Text("완료")
                        .font(.cafeHeadline2)
                        .foregroundColor(.black)
                }
            }
            
            
        }
        
        .background(Color(red: 252/255, green: 251/255, blue: 245/255))
    }
}

struct AddFeedView_Previews: PreviewProvider {
    static var previews: some View {
        AddFeedView()
    }
}

