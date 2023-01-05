//
//  AddfeedView.swift
//  hackathonPreview
//
//  Created by 장다영 on 2023/01/05.
//

import SwiftUI
import PhotosUI

struct AddFeedView: View {
    
    var drawingCategory = ["풍경 그림", "캐릭터 그림", "인물 그림", "동물 그림"]
    @State private var currentCategory : Int = 0
    @State private var drawingDescription : String = ""
    @State private var selectedImage: PhotosPickerItem? = nil
    @State private var selectedImageData: Data? = nil
    
    var body: some View {
        VStack {
            Text("새 게시물")
            //MARK: - 사용자의 그림
            PhotosPicker(
                selection: $selectedImage,
                matching: .images,
                photoLibrary: .shared()) {
                    if selectedImageData == nil {
                        Text("이미지를 선택해주세요")
                            .font(.largeTitle)
                            .frame(width:UIScreen.main.bounds.size.width, height:UIScreen.main.bounds.size.width)
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
                    Spacer()
                    Picker(selection: $currentCategory, label: Text("Picker")) {
                        ForEach(0..<drawingCategory.count) {
                            Text(drawingCategory[$0])
                        }
                    }
                    .pickerStyle(.menu)
                    .tint(.black)
                }
                Divider()
            }
            .padding()
            
            // MARK: - 문구 입력
            VStack {
                HStack {
                    Text("문구입력")
                    Spacer()
                }
                TextEditor(text: $drawingDescription)

            }
            .padding([.leading, .trailing])
            Spacer()
            
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button("완료") {
                    
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

