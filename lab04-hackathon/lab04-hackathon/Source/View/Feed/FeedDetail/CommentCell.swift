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
    // =============================
    
    var body: some View {
        
        ZStack {
            
            Color("background")
                .ignoresSafeArea()
            
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 20.0) {
                    component(isFeed: true)
                    
                    Divider()
                    ForEach(Comment.dummy, id: \.commentId) { comment in
                        component(comment: comment)
                    }
                    
                }
            }
            .padding(.bottom, 115)
            .navigationTitle("Comments")
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
                            TextField("Add a comment as `user`", text: $commentString, axis: .vertical)
                                .font(.cafeCallout2)
                                .lineLimit(6)
                            
                            Button {
                                //
                            } label: {
                                Text("올리기")
                                    .font(.cafeCallout2)
                            }
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
        }
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
                        .font(.cafeHeadline)
                    Text(isFeed ? feed.date.dayFormmat : comment?.date.dayFormmat ?? "")
                        .font(.cafeCallout2)
                        .foregroundColor(.secondary)
                }
                Text(isFeed ? feed.description : comment?.content ?? "")
                    .font(.cafeCallout2)
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
        case 1..<7:
            return String(format: "%.f", date) + "d"
        case 7..<365:
            return String(format: "%.f", date / 7.0) + "w"
        default:
            return "today"
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
