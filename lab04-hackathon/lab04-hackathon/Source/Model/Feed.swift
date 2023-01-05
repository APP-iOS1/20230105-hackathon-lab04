import Foundation

struct Feed: Codable {
    var feedId: String
    var userId: String
    var title: String
    var imageURL: String
    var description: String
    var category : String
    //var liked: Int
    var userName: String
    var date: Double
    
    var createdDate: String {
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "ko_kr")
            dateFormatter.timeZone = TimeZone(abbreviation: "KST")
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm" // "yyyy-MM-dd HH:mm:ss"

            let dateCreatedAt = Date(timeIntervalSince1970: date)

            return dateFormatter.string(from: dateCreatedAt)
        }
    
}
