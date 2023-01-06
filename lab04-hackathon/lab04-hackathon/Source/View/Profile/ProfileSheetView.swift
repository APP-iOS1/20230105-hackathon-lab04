//
//  ProfileSheetView.swift
//  lab04-hackathon
//
//  Created by zooey on 2023/01/06.
//

import SwiftUI

struct ProfileSheetView: View {
    
    @State private var myProfileText: String = "나를 표현해보세요"
    @State private var myProfileDescription: String = ""
    @Environment(\.dismiss) private var dismiss
    @Binding var sheetShowing: Bool
    
    var body: some View {
        
        ZStack {
            Color("background")
                .ignoresSafeArea()
            
            VStack {
                if myProfileDescription.isEmpty {
                    TextEditor(text: $myProfileText)
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
                    TextEditor(text: $myProfileDescription)
                        .font(.cafeHeadline2)
                        .overlay (
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(lineWidth: 0.3)
                                .foregroundColor(.gray)
                        )
                        .frame(width:UIScreen.main.bounds.size.width-40, height: 200)
                }
                
                Button {
                    dismiss()
                } label: {
                    Text("완료")
                        .font(.cafeHeadline2)
                        .foregroundColor(.black)
                }
            }
        }
    }
}

struct ProfileSheetView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileSheetView(sheetShowing: .constant(true))
    }
}
