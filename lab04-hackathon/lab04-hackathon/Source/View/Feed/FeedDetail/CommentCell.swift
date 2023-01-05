//
//  CommentCell.swift
//  lab04-hackathon
//
//  Created by Park Jungwoo on 2023/01/05.
//

import SwiftUI

struct CommentCell: View {
    var body: some View {
        VStack {
            // 댓글
            HStack {
                // 프로필
                Group {
                    Image(systemName: "person.circle.fill")
                    Text("주희 :").offset(x: -5)
                    Text("햄뿡이 기여워").offset(x: -5)
                }
                Spacer()
            }
        }
    }
}

struct CommentCell_Previews: PreviewProvider {
    static var previews: some View {
        CommentCell()
    }
}
