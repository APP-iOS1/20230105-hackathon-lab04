// 2023/01/05 created by 서광현.

/// User정보에 대한 구조체입니다.
struct User {
    /// user의 고유 uid
    let userId: String
    /// user의 이름
    let username: String
    /// user의 email
    let email: String
    /// 한 줄 소개
    let introduce: String
    /// 팔로워 배열
    let followers: [String]?
    /// 팔로잉 배열
    let following: [String]?
    
    static let dummy: [User] = (0..<10).map {
        User(
            userId: UUID().uuidString,
            username: "user\($0)",
            email: "test\($0)@gmail.com",
            introduce: "ㄱr 끔은 떡볶이ㄱr 좋ㅇr.."
        )
    }
}
