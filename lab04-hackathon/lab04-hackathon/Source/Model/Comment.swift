// 2023/01/05 created by 서광현.

import Foundation

/// Comment정보에 대한 구조체입니다.
struct Comment {
    /// comment의 id
    var commentId: String
    /// feed의 id
    var feedId : String
    /// user의 uid 
    var userId : String
    /// user이름
    var userName: String
    /// 댓글
    var content: String
    /// 작성 날짜(Double타입)
    var date: Date
    //var liked: Int
    /// 날짜(String타입) 연산 프로퍼티
    var createdDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_kr")
        dateFormatter.timeZone = TimeZone(abbreviation: "KST")
        dateFormatter.dateFormat = "yyyy-MM-dd" // "yyyy-MM-dd HH:mm:ss"
        // 몇분전/ 몇일전/ 몇달전/ 몇년전
        return dateFormatter.string(from: date)
    }
    
    static var dummy: [Comment] = (0..<10).map {
        Comment(
            commentId: UUID().uuidString,
            feedId: UUID().uuidString,
            userId: UUID().uuidString,
            userName: "name\($0)",
            content: "content\($0)",
            date: Date().addingTimeInterval(.random(in: -2*60*60...2*60*60))
        )
    }
}
