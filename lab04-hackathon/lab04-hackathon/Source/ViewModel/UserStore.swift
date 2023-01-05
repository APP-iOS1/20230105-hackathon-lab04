//
//  UserStore.swift
//  lab04-hackathon
//
//  Created by 지정훈 on 2023/01/05.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class UserStore : ObservableObject{
    
    private let db = Firestore.firestore()
    let uid = FirebaseAuth.Auth.auth().currentUser?.uid
    @Published var user : User = User(userId: "", userName: "", email: "", introduce: "")
    
    func requestUserData(){
                                        
        db.collection("User").document(uid ?? "").getDocument { snapshot,error in
            if let snapshot {
                let docData = snapshot.data()
                
                let email : String = docData?["email"] as? String ?? ""
                let userId : String = docData?["userId"] as? String ?? ""
                let userName : String = docData?["userName"] as? String ?? ""
                //followers
                //following
                let user = User(userId: userId, userName: userName, email: email, introduce: "")
                self.user = user
                
            }
        }

    }
}
