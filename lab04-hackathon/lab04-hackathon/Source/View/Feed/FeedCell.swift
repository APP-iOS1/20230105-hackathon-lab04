//
//  FeedCell.swift
//  lab04-hackathon
//
//  Created by Park Jungwoo on 2023/01/05.
//

import SwiftUI

struct FeedCell: View {
    @ObservedObject var user: UserStore = UserStore()
    @StateObject var commentStore: CommentStore = CommentStore()
    let feed: Feed
    
    var body: some View {
        
        ZStack {
            Color("background")
                .ignoresSafeArea()
            
            VStack {
                // 제목
                HStack {
                    Text(feed.title)
                        .font(.custom("Cafe24Ssurround", size: 23))
                        .padding(EdgeInsets(top: 5, leading: 10, bottom: -5, trailing: 0))
                    Spacer()
                }
                
//                 사진
                Image(uiImage: feed.feedImage ?? UIImage())
                    .resizable()
                    .frame(width: Screen.maxWidth, height: Screen.maxWidth)
                    .padding(.top, 10)
                    .padding(.bottom, 10)

                Group {
                    HStack {
                        // 하트

//                        Group {
//
//                            Image("like")
//                                .resizable()
//                                .scaledToFit()
//                                .frame(width: 20)
//                            Text("1234")
//                                .font(.cafeCallout2)
//                        }
                        
                        // 댓글
                        Group {
                            Image("comment")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 23)
                            Text("\(commentStore.comments.count)")
                                .font(.cafeCallout2)
                        }
                        Spacer()
                        Text("\(feed.createdDate)")
                            .font(.cafeCallout2)
                    }
                    .padding(.top, 10)
                    .padding(.bottom, 10)
                    // 피드 Description
                    HStack {
                        Text(feed.description)
                            .font(.cafeHeadline2)
                        Spacer()
                    }
                    .padding(.bottom, 10)
                    // 댓글
                    HStack {
                        // 프로필
                        Group {
                            Image("person")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20)
                                .opacity(commentStore.comments.isEmpty ? 0 : 1)
                            Text("\(commentStore.comments.first?.userName ?? "")").offset(x: -5)
                                .font(.cafeCallout2)
                            Text("\(commentStore.comments.first?.content ?? "")")
                                .offset(x: -5)
                                .font(.cafeCallout2)
                                .lineLimit(1)
                                .truncationMode(Text.TruncationMode.tail)
                        }
                        Spacer()
                        NavigationLink {
                            CommentCell(feed: feed, commentStore: commentStore)
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
        .onAppear {
            commentStore.read(feedId: feed.feedId)
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
