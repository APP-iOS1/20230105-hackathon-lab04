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
    @EnvironmentObject var userStore: UserStore
    @ObservedObject var commentStore: CommentStore
    @State private var commentString: String = ""
    
    var currentUser: User {
        userStore.requestUserData()
        return userStore.user
    }
    
    var body: some View {
        List {
            component(isFeed: true)
                .listRowBackground(Color("background"))
                .listRowSeparator(.hidden, edges: .top)
                .listRowSeparator(SwiftUI.Visibility.visible, edges: .bottom)
            ForEach(commentStore.comments, id: \.commentId) { (comment: Comment) in
                component(comment: comment)
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color("background"))
                    .swipeActions {
                        Button("삭제", role: .destructive) {
                            commentStore.delete(comment: comment)
                            if let index = commentStore.comments.firstIndex(where: { comment.commentId == $0.commentId }) {
                                commentStore.comments.remove(at: index)
                            }
                        }
                        .disabled(comment.userId != currentUser.userId)
                    }
            }
        }
        .listStyle(.plain)
        .background(content: {
            Color("background")
                .ignoresSafeArea()
        })
        .padding(.bottom, 110)
        .navigationTitle("댓글")
        .navigationBarTitleDisplayMode(.inline)
        .overlay(alignment: .bottom) {
            VStack(alignment: .center, spacing: 12.0) {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(alignment: .center, spacing: 12.0) {
                        ForEach(emojis, id: \.hashValue) { emoji in
                            Button {
                                self.commentString.append(emoji)
                            } label: {
                                Text(emoji)
                                    .font(.system(size: 24))
                                    .font(.cafeTitle2)
                            }
                        }
                    }
                }
                
                HStack(alignment: .center, spacing: 6.0) {
                    Image("person")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30, alignment: .center)
                    
                    HStack(alignment: .bottom) {
                        TextField("'\(currentUser.userName)'로 댓글 남기기", text: $commentString, axis: .vertical)
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
                            commentStore.comments.insert(comment, at: 0)
                            hideKeyboard()
                            commentString = ""
                        }
                        .font(.cafeSubhead)
                        .disabled(commentString.isEmpty)
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
            .keyboardType(UIKeyboardType.twitter)
        }
        .scrollDismissesKeyboard(.interactively)
        .onTapGesture {
            hideKeyboard()
        }
    }
    
    func component(comment: Comment? = nil, isFeed: Bool = false) -> some View {
        HStack(alignment: .top, spacing: 6.0) {
           Image("person")
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30, alignment: .center)
            
            VStack(alignment: .leading, spacing: 6.0) {
                HStack {
                    Text(isFeed ? feed.userName : comment?.userName ?? "")
                        .font(.cafeCallout)
                    Text(isFeed ? feed.date.dayFormmat : comment?.date.dayFormmat ?? "")
                        .font(.cafeCaption)
                        .foregroundColor(.secondary)
                }
                    Text(isFeed ? feed.description : comment?.content ?? "")
                        .font(.cafeCallout2)
                        .lineLimit(3)
            }
        }
    }
}

