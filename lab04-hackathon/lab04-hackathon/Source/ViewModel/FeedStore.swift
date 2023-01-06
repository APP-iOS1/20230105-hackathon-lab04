import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage
import UIKit


class FeedStore: ObservableObject {
    private let db = Firestore.firestore()
    private let storage = Storage.storage()
    
    private let uid = FirebaseAuth.Auth.auth().currentUser?.uid
    //let email = Auth.auth().currentUser?.email
    @Published var feeds: [Feed] = []
    @Published var feedsorted: [Feed] = []
    
    init () {
        read()
    }
    
    func create(_ feed: Feed) {
        
        db.collection("Feed")
            .document(feed.feedId)
            .setData([
                "feedId" : feed.feedId,
                "userId" : feed.userId,
                "title": feed.title,
                //"author": feed.userName,
                "userName": feed.userName,
                "date": feed.date,
                "description": feed.description,
                "category" : feed.category,
                //"liked": feed.liked,
                "imageURL": feed.imageURL
            ])
    }
    
    //수정완료
    func read() {
        
        db.collection("Feed").order(by: "date", descending: true)
            .addSnapshotListener { snapshot, error in
                self.feeds.removeAll()
                self.feedsorted.removeAll()

                if let snapshot = snapshot {
                    for document in snapshot.documents {
                        let feedId: String = document.documentID
                        let docData = document.data()
                        let userId: String = docData["userId"] as? String ?? ""
                        let title = docData["title"] as? String ?? ""
                        let date = (docData["date"] as? Timestamp)?.dateValue() ?? Date()
                        let description = docData["description"] as? String ?? ""
                        //let liked = docData["liked"] as? Int ?? 0
                        let category = docData["category"] as? String ?? ""
                        let userName = docData["userName"] as? String ?? ""
                        let imageURL = docData["imageURL"] as? String ?? ""
                        
                        let storageRef = Storage.storage().reference()
                        let fileRef = storageRef.child("images/\(imageURL)")
                        
                        fileRef.getData(maxSize: 5 * 1024 * 1024) { data, error in
                            if error == nil && data != nil {
                                let uiImage = UIImage(data: data!)!
                                let feed = Feed(feedId: feedId, userId: userId, title: title, imageURL: imageURL, description: description, category: category, userName: userName, date: date, feedImage: uiImage)
                                self.feeds.append(feed)
                                self.feedsorted.append(feed)
                                self.feeds.sort(by: {$0.createdDate > $1.createdDate})
                                self.feedsorted.sort(by: {$0.createdDate > $1.createdDate})
                            }
                        }
                    }
                }
            }
        
    }
    
    //미사용 추천
    func update(_ feed: Feed) {
        
        db.collection("Feed")
            .document(feed.feedId)
            .updateData([
                "userId" : feed.userId,
                "title": feed.title,
                "userName": feed.userName,
                "date": feed.date,
                "description": feed.description
                //"liked": feed.liked,
            ])
    }
    
    
    //검증필요 현재유저와 userid가 같을때 삭제
    func delete(_ feed: Feed) {
        db.collection("Feed")
            .document(feed.feedId)
            .delete()
    }
    
    // 사진 업로드
    func uploadImage(image: Data?, imageURL: String) {
        let storageRef = storage.reference().child("images/\(imageURL)") //images/postId/imageName
        let data = image
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        
        if let data = data{
            storageRef.putData(data, metadata: metadata) {(metadata, error) in
                if let error = error {
                    print("Error: \(error)")
                }
                if let metadata = metadata {
                    print("metadata: \(metadata)")
                }
            }
        }
    }
    //사진 불러오기
    func retrievePhotos(_ feed: Feed) {
        
        db.collection("Feed").getDocuments { snapshot, error in
            if error == nil && snapshot != nil {
                
                let imageName: String = feed.imageURL
                
                let storageRef = Storage.storage().reference()
                let fileRef = storageRef.child("images/\(imageName)")
                
                fileRef.getData(maxSize: 5 * 1024 * 1024) { data, error in
                    
                    if error == nil && data != nil {
                        let uiImage = UIImage(data: data!)!
                    }
                }
            }
        }
    }
    
    
}

struct FeedImage: Hashable {
    var feedId: String
    var image: UIImage
}
