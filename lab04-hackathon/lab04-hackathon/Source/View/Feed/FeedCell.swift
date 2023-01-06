//
//  FeedCell.swift
//  lab04-hackathon
//
//  Created by Park Jungwoo on 2023/01/05.
//

import SwiftUI

struct FeedCell: View {
    @EnvironmentObject var user: UserStore
    let feed: Feed
    
    var body: some View {
        
        ZStack {
            Color("background")
                .ignoresSafeArea()
            
            VStack {
                // 제목
                HStack {
                    Text(feed.title)
                        .font(.cafeTitle)
                        .padding(EdgeInsets(top: 5, leading: 5, bottom: -5, trailing: 0))
                    Spacer()
                }
                
//                 사진
                Image(uiImage: feed.feedImage ?? UIImage())
                    .resizable()
                    .frame(width: Screen.maxWidth, height: Screen.maxWidth)

                Group {
                    HStack {
                        // 하트
                        Group {
                            
                            Image("like")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20)
                            Text("1234")
                                .font(.cafeCallout2)
                        }
                        
                        // 댓글
                        Group {
                            Image("comment")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20)
                            Text("12")
                                .font(.cafeCallout2)
                        }
                        Spacer()
                        Text("\(feed.createdDate)")
                            .font(.cafeCallout2)
                    }
                    // 피드 Description
                    HStack {
                        Text(feed.description)
                            .font(.cafeCallout2)
                        Spacer()
                    }
                    // 댓글
                    HStack {
                        // 프로필
                        Group {
                            Image("person")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20)
                            Text("주희 :").offset(x: -5)
                                .font(.cafeCallout2)
                            Text("햄뿡이 기여워").offset(x: -5)
                                .font(.cafeCallout2)
                        }
                        Spacer()
                        NavigationLink {
                            CommentCell(feed: feed)
                                .environmentObject(user)
                        } label: {
                            Text("댓글 모두 보기")
                                .font(.cafeCallout2)
                                .foregroundColor(.gray)
                        }
                    }
                }.padding([.leading, .trailing], 10)
                Divider()
            }
        }
    }
}

struct FeedCell_Previews: PreviewProvider {
    static var feed = Feed(
        feedId: UUID().uuidString,
        userId: UUID().uuidString,
        title: "title\(1)",
        imageURL: "https://cdn.clien.net/web/api/file/F01/8943891/37854b4f3dc856.png?w=780&h=30000",
        description: "\(1)",
        category: "category\(1)",
        userName: "author\(1)",
        date: Date().addingTimeInterval(.random(in: -1*24*60*60...2*60*60))
    )
    static var previews: some View {
        FeedCell(feed: feed)
    }
}
