//
//  FeedCell.swift
//  lab04-hackathon
//
//  Created by Park Jungwoo on 2023/01/05.
//

import SwiftUI

struct FeedCell: View {
    let feed: Feed
    
    var body: some View {
        VStack {
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
    }
}

struct FeedCell_Previews: PreviewProvider {
    static var feed = Feed(
        feedId: UUID().uuidString,
        userId: UUID().uuidString,
        title: "title\(1)",
        imageURL: "https://cdn.clien.net/web/api/file/F01/8943891/37854b4f3dc856.png?w=780&h=30000",
        description: "\(1) : description description description ",
        category: "category\(1)",
        userName: "author\(1)",
        date: Date().addingTimeInterval(.random(in: -1*24*60*60...2*60*60))
    )
    static var previews: some View {
        FeedCell(feed: feed)
    }
}
