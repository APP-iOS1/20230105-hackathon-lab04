import Foundation

struct User {
    var userId: String // <- auth.uid
    var username: String
    var followers: [String]?
    var following: [String]?
    var email: String
    
    
}
