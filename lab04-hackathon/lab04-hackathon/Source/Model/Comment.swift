import Foundation

struct Comment {
    var commentId: String
    var feedId : String
    var userId : String
    var userName : String
    var content: String
    var date: Double
    //var liked: Int
    
    var createdDate: String {
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "ko_kr")
            dateFormatter.timeZone = TimeZone(abbreviation: "KST")
            dateFormatter.dateFormat = "yyyy-MM-dd" // "yyyy-MM-dd HH:mm:ss"

            let dateCreatedAt = Date(timeIntervalSince1970: date)

            return dateFormatter.string(from: dateCreatedAt)
        }
}
