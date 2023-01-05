import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage
import UIKit


class FeedsViewModel: ObservableObject {
    private let db = Firestore.firestore()
    private let uid = FirebaseAuth.Auth.auth().currentUser?.uid
    let email = Auth.auth().currentUser?.email
    @Published var feeds: [Feed] = []
    
    init () {
        read()
    }
    
    func create(_ feed: Feed) {
        
        db.collection("feeds")
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
                
                if let snapshot = snapshot {
                    for document in snapshot.documents {
                        let feedId: String = document.documentID
                        let docData = document.data()
                        let userId: String = docData["userId"] as? String ?? ""
                        let title = docData["title"] as? String ?? ""
                        let date = docData["date"] as? Double ?? 0.0
                        let description = docData["description"] as? String ?? ""
                        //let liked = docData["liked"] as? Int ?? 0
                        let category = docData["category"] as? String ?? ""
                        let userName = docData["userName"] as? String ?? ""
                        let imageURL = docData["imageURL"] as? String ?? ""
                        
                        let feed = Feed(feedId: feedId, userId: userId, title: title, imageURL: imageURL, description: description, category: category, userName: userName, date: date)
                        
                        self.feeds.append(feed)
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
    
    /// storage에 저장하기
    ///
    /// - 12조 코드 ( 100번째줄 ) 참고: [https://github.com/APPSCHOOL1-REPO/FirestoreApp-20221212-team12-planB/blob/main/Nautica/Nautica/Model/FeedStore.swift](https://github.com/APPSCHOOL1-REPO/FirestoreApp-20221212-team12-planB/blob/main/Nautica/Nautica/Model/FeedStore.swift)
    func uploadStorage(image: UIImage, completion: @escaping (URL?) -> Void) {
        let storage = Storage.storage(url:"gs://hellodemo-2ff28.appspot.com/")
        let storageRef = storage.reference()
        
        let user = Auth.auth().currentUser
        let createdAt: Date = Date()
        
        // Create a child reference
        // imagesRef now points to "images"
        let imagesRef = storageRef.child("images")
        
        // Child references can also take paths delimited by '/'
        // spaceRef now points to "images/space.jpg"
        // imagesRef still points to "images"
        var spaceRef = storageRef.child("images/" +  "\(user?.email ?? "")" + "\(createdAt.description)" + "\(UUID())" + ".jpg")
        
        // This is equivalent to creating the full reference
        //let storagePath = "gs://nautica-7bd02.appspot.com/images/space.jpg"
        //spaceRef = storage.reference(forURL: storagePath)
        
        // Data in memory
        guard let data = image.jpegData(compressionQuality: 0.3) else { return }
        
        var metatdata: StorageMetadata = StorageMetadata()
        
        metatdata.contentType = "image/jpeg"
        
        // Upload the file to the path "images/rivers.jpg"
        let uploadTask = spaceRef.putData(data, metadata: metatdata) { (metadata, error) in
            guard let metadata = metadata else {
                // Uh-oh, an error occurred!
                return
            }
            // Metadata contains file metadata such as size, content-type.
            let size = metadata.size
            // You can also access to download URL after upload.
            spaceRef.downloadURL { (url, error) in
                guard let downloadURL = url else {
                    // Uh-oh, an error occurred!
                    return
                }
                completion(downloadURL)
            }
        }
    }
}
