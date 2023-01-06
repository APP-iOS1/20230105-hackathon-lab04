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
                let introduce : String = docData?["introduce"] as? String ?? ""
                //followers
                //following
                let user = User(userId: userId, userName: userName, email: email, introduce: introduce)
                self.user = user
                
            }
        }
    }
    
    func createUserData(uid: String,userName: String){
        db.collection("User").document(uid).setData([
            "email" : "준비 중",
            "followers" : [""],
            "following" : [""],
            "userId" : uid,
            "userName" : userName,
            "introduce" : ""
        ])
    }
    
    // 자기소개 업데이트
    func updateUserDataIntroduce(content: String) -> String{
        db.collection("User").document(uid ?? "").updateData([
            "introduce": content
        ])
        return content
    }
    // 자기소개 빈칸 만들기
    func updateUserDataIntroduceBlank(){
        db.collection("User").document(uid ?? "").updateData([
            "introduce": ""
        ])
    }
    
}
