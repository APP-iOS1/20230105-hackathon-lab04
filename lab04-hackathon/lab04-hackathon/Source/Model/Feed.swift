// 2023/01/05 created by 서광현.

/// Feed정보에 대한 구조체입니다.
struct Feed {
    /// feed 고유 아이디
    let feedId: String
    /// user의 uid
    let userId : String
    /// 피드 제목
    let title: String
    /// 이미지 URL
    let imageURL: String
    /// 피드 내용
    let description: String
    /// 피드 구분 ( 카테고리 )
    let category : String
    /// 좋아요 ( 개발예정 )
    //var liked: Dictionay<user.id:Bool>
    /// 작성자
    let userName: String
    /// 댓글뷰에서 구현할거라 사용 안함
    // var comments: [Comment]?
    /// 작성날짜 ( Double )
    let date: Date
    /// 작성날짜 ( String )
    var createdDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_kr")
        dateFormatter.timeZone = TimeZone(abbreviation: "KST")
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm" // "yyyy-MM-dd HH:mm:ss"
        return dateFormatter.string(from: date)
    }
    
    static let dummy: [Feed] = (0..<10).map {
        Feed(
            feedId: UUID().uuidString,
            userId: UUID().uuidString,
            title: "title\($0)",
            imageURL: "https://cdn.clien.net/web/api/file/F01/8943891/37854b4f3dc856.png?w=780&h=30000",
            description: "\($0) : description description description ",
            category: "category\($0)",
            userName: "author\($0)",
            date: Date().addingTimeInterval(.random(in: -1*24*60*60...2*60*60))
        )
    }
}
