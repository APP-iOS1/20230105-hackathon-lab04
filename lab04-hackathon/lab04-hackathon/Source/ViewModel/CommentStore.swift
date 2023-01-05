// CommentStore.swift
// 2023/01/05 created by 서광현
//

import FirebaseFirestore
import FirebaseFirestoreSwift

// TODO: Comment CRUD
/// Comment 데이터를 CRUD하는 class.
///
/// 1. creat: create a comment data with both `feedId` and `user.uid`
/// 2. read: read comments data with `feedId`
/// 3. update: update a comment specified by `feedId`and `user.uid`
/// 4. delete: delete a comment specified by `feedId` and `user.uid`
final class CommentStore: ObservableObject {
    @Published var comments: [Comment] = []
    private var ref = Firestore.firestore()
    
    var listener: ListenerRegistration?
    
    func read(feedId: String) {
        listener = ref.collection("Comment")
            .whereField("feedId", isEqualTo: feedId)
            .addSnapshotListener({ snapshot, error in
                if let error = error { print(error) }
                
                guard let documents = snapshot?.documents else { return }
                self.comments = documents.map {
                    let dict: [String: Any] = $0.data()
                    let commentId = dict["commentId"] as? String ?? ""
                    let feedId = dict["feedId"] as? String ?? ""
                    let userId = dict["userId"] as? String ?? ""
                    let userName = dict["userName"] as? String ?? ""
                    let content = dict["content"] as? String ?? ""
                    let date = (dict["date"] as? Timestamp)?.dateValue() ?? Date()
                    
                    return Comment(
                        commentId: commentId,
                        feedId: feedId,
                        userId: userId,
                        userName: userName,
                        content: content,
                        date: date
                    )
                }
            })
    }
    
    func create(content: String, feed: Feed, user: User) {
        let commentId: String = UUID().uuidString
        ref.collection("Comment")
            .document(commentId)
            .setData([
                "commentId": commentId,
                "feedId": feed.feedId,
                "userId": user.userId,
                "userName": user.userName,
                "content": content,
                "date": Date()
            ])
    }

    func update(content: String, comment: Comment) {
        ref.collection("Comment")
            .document(comment.commentId)
            .updateData([
                "content": content
            ])
    }
    
    func delete(comment: Comment, user: User) {
        if comment.userId == user.userId {
            ref.collection("Comment")
                .document(comment.commentId)
                .delete()
        }
    }
    
    func detachListener() {
        listener?.remove()
    }
}
