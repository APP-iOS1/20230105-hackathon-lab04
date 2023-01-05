// 2023/01/05 created by 서광현.
import Foundation

/// Drawing정보에 대한 구조체입니다.
struct Drawing {
    /// drawing의 id
    let drawingId: String
    /// user의 id
    let userId: String
    /// 이미지 URL
    let imageURL: String
    
    static let dummy: [Drawing] = (0..<10).map { _ in
        Drawing(
            drawingId: UUID().uuidString,
            userId: UUID().uuidString,
            imageURL: "https://mblogthumb-phinf.pstatic.net/MjAyMDA1MThfMjY5/MDAxNTg5NzUzMzM3NTg3.9xYE5Jg6mp6WB_Qj3K6VaYjb7p5acUYar9OPAhbSIcgg.kC1r2uOTP2fNibRmHhWVWoePv490JL0BR_tpyZUfybQg.JPEG.yogocode/SE-72f300cc-0f44-4c5d-b7de-f2365958ad61.jpg?type=w800"
        )
    }
}

