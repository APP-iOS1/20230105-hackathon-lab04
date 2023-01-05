//
//  FeedMenu.swift
//  lab04-hackathon
//
//  Created by Park Jungwoo on 2023/01/05.
//

import SwiftUI

struct FeedMenu: View {
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            HStack {
                Image("folder")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20)
                    
                Text("전체 게시물")
                    .font(.cafeHeadline2)
                
            }.padding(.top, 100)
            
            HStack {
                Image("folder")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20)
                
                Text("풍경 그림")
                    .font(.cafeHeadline2)
                
            }.padding(.top, 30)
            
            HStack {
                Image("folder")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20)
                
                Text("캐릭터 그림")
                    .font(.cafeHeadline2)
                
            }.padding(.top, 30)
            
            HStack {
                Image("folder")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20)
                
                Text("인물 그림")
                    .font(.cafeHeadline2)
                
            }.padding(.top, 30)
            
            HStack {
                Image("folder")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20)
                
                Text("동물 그림")
                    .font(.cafeHeadline2)
                
            }.padding(.top, 30)
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color("background"))
        .edgesIgnoringSafeArea(.all)
    }
}

struct FeedMenu_Previews: PreviewProvider {
    static var previews: some View {
        FeedMenu()
    }
}
