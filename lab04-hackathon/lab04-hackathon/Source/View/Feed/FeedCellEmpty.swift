//
//  FeedCellEmpty.swift
//  lab04-hackathon
//
//  Created by Park Jungwoo on 2023/01/06.
//

import SwiftUI

struct FeedCellEmpty: View {
    var body: some View {
        VStack {
            Text("텅")
                .font(.cafeLargeTitle)
        }
    }
}

struct FeedCellEmpty_Previews: PreviewProvider {
    static var previews: some View {
        FeedCellEmpty()
    }
}
