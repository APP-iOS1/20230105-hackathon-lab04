//
//  CommentCell.swift
//  lab04-hackathon
//
//  Created by Park Jungwoo on 2023/01/05.
//

import SwiftUI

struct CommentCell: View {
    let feed: Feed
    let emojis: [String] = ["🥰","🧐","🥹","😏","🙁","😒","😄","😅","😡","🥱","😪","🫠","😩","😐"]
    @EnvironmentObject var authViewModel: AuthenticationViewModel
    @StateObject var commentStore: CommentStore = CommentStore()
    @State private var commentString: String = ""
    
    // temp ========================
    let uid = "GasLC2yL2kc8EshBbVtI"
    @StateObject var userStore = UserStore()
    var currentUser: User {
        userStore.requestUserData(uid: uid)
        return userStore.user
    }
    // =============================
    
    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 20.0) {
                component(isFeed: true)
                
                Divider()
                ForEach(commentStore.comments, id: \.commentId) { comment in
                    component(comment: comment)
                }
                
            }
        }
        .onAppear(perform: {
            commentStore.read(feedId: feed.feedId)
        })
        .onDisappear(perform: {
            commentStore.detachListener()
        })
        .padding(.bottom, 115)
        .navigationTitle("댓글")
        .navigationBarTitleDisplayMode(.inline)
        .background { Color("background").ignoresSafeArea(.all, edges: [.horizontal, .bottom]) }
        .overlay(alignment: .bottom) {
            commentInpuView
        }
    }
    
    var commentInpuView: some View {
        VStack(alignment: .center, spacing: 12.0) {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .center, spacing: 12.0) {
                    ForEach(emojis, id: \.hashValue) { emoji in
                        Button {
                            self.commentString.append(emoji)
                        } label: {
                            Text(emoji)
                                .font(.cafeTitle2)
                        }
                    }
                }
            }
            
            HStack(alignment: .center, spacing: 6.0) {
                AsyncImage(url: URL(string: feed.imageURL)) {
                    $0
                        .resizable()
                        .aspectRatio(1.0, contentMode: .fit)
                        .frame(width: 50.0, height: 50.0)
                        .clipShape(Circle())
                        .background { Circle().stroke(lineWidth: 0.1)
                        }
                } placeholder: {
                    ProgressView()
                }
                
                HStack(alignment: .bottom) {
                    TextField("\(currentUser.userName)로 댓글 남기기", text: $commentString, axis: .vertical)
                        .font(.cafeCaption)
                        .lineLimit(6)
                    Button("Post") {
                        let comment = Comment(
                            commentId: UUID().uuidString,
                            feedId: feed.feedId,
                            userId: currentUser.userId,
                            userName: currentUser.userName,
                            content: commentString,
                            date: .now
                        )
                        
                        commentStore.create(with: comment)
                    }
                    .font(.cafeSubhead)
                }
                .padding(11)
                .background {
                    RoundedRectangle(cornerRadius: 20.0)
                        .stroke(lineWidth: 0.2)
                }
            }
        }
        .padding(12.0)
        .background(Color.white)
        .overlay(alignment: .top) {
            Rectangle().frame(height: 0.2).foregroundColor(.secondary)
        }
        .scrollDismissesKeyboard(.interactively)
        .keyboardType(UIKeyboardType.twitter)
    }
    
    func component(comment: Comment? = nil, isFeed: Bool = false) -> some View {
        HStack(alignment: .top, spacing: 6.0) {
            if isFeed{
                AsyncImage(url: URL(string: feed.imageURL)) {
                    $0
                        .resizable()
                        .aspectRatio(1.0, contentMode: .fit)
                        .frame(width: 30.0, height: 30.0)
                        .clipShape(Circle())
                        .background { Circle().stroke(lineWidth: 0.5)}
                } placeholder: {
                    ProgressView()
                }
            }
            else {
                Circle()
                    .frame(width: 30, height: 30)
                    .opacity(1)
            }
            
            VStack(alignment: .leading, spacing: 6.0) {
                HStack {
                    Text(isFeed ? feed.userName : comment?.userName ?? "")
                        .font(.cafeCallout)
                    Text(isFeed ? feed.date.dayFormmat : comment?.date.dayFormmat ?? "")
                        .font(.cafeCaption)
                        .foregroundColor(.secondary)
                }
                Text(isFeed ? feed.description : comment?.content ?? "")
                    .font(.cafeCaption2)
                    .lineLimit(3)
            }
        }
        .padding(.horizontal, 12.0)
    }
}

extension Date {
    var dayFormmat: String {
        let date = abs(self.timeIntervalSince(.now) / 3600.0)
        switch date {
        case 0..<1:
            return "오늘"
        case 1..<7:
            return String(format: "%.f", date) + "일전"
        case 7..<365:
            return String(format: "%.f", date / 7.0) + "주전"
        default:
            return String(format: "%.f", date / 365.0) + "년전"
        }
    }
}

struct CommentCell_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            CommentCell(feed: Feed.dummy[4])
            //            .environmentObject(AuthenticationViewModel())
        }
            .environmentObject(FeedStore())
    }
}
