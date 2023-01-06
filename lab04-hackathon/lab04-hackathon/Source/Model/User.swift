import Foundation
// 2023/01/05 created by 서광현.

/// User정보에 대한 구조체입니다.
struct User {
    /// user의 고유 uid
    var userId: String
    /// user의 이름
    var userName: String
    /// user의 email
    var email: String
    /// 한 줄 소개
    var introduce: String?
    /// 팔로워 배열
    var followers: [String]?
    /// 팔로잉 배열
    var following: [String]?
    static var dummy: [User] = (0..<10).map {
        User(
            userId: UUID().uuidString,
            userName: "user\($0)",
            email: "test\($0)@gmail.com",
            introduce: "ㄱr 끔은 떡볶이ㄱr 좋ㅇr.."
        )
    }
}
