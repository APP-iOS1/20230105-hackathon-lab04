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
                Image(systemName: "person")
                    .foregroundColor(.gray)
                    .imageScale(.large)
                Text("전체 게시물")
                    .foregroundColor(.gray)
                    .font(.headline)
            }.padding(.top, 100)
            
            HStack {
                Image(systemName: "person")
                    .foregroundColor(.gray)
                    .imageScale(.large)
                Text("풍경 그림")
                    .foregroundColor(.gray)
                    .font(.headline)
            }.padding(.top, 30)
            
            HStack {
                Image(systemName: "person")
                    .foregroundColor(.gray)
                    .imageScale(.large)
                Text("캐릭터 그림")
                    .foregroundColor(.gray)
                    .font(.headline)
            }.padding(.top, 30)
            
            HStack {
                Image(systemName: "person")
                    .foregroundColor(.gray)
                    .imageScale(.large)
                Text("인물 그림")
                    .foregroundColor(.gray)
                    .font(.headline)
            }.padding(.top, 30)
            
            HStack {
                Image(systemName: "person")
                    .foregroundColor(.gray)
                    .imageScale(.large)
                Text("동물 그림")
                    .foregroundColor(.gray)
                    .font(.headline)
            }.padding(.top, 30)
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(red: 52/255, green: 52/255, blue: 52/255))
        .edgesIgnoringSafeArea(.all)
    }
}

struct FeedMenu_Previews: PreviewProvider {
    static var previews: some View {
        FeedMenu()
    }
}
