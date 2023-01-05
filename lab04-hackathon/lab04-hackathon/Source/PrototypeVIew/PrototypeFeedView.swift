//
//  PrototypeFeedView.swift
//  lab04-hackathon
//
//  Created by 지정훈 on 2023/01/05.
//

import SwiftUI

struct PrototypeFeedView: View {
    var body: some View {
        VStack {
            HStack{
                Button {
                    
                } label: {
                    Text("햄버거")
                }
                Spacer()
                Button {
                    
                } label: {
                    Text("플러스")
                }
            }
            
            VStack(alignment: .leading){
                
                List{
                    Text("햄뿡이")
                    Image(systemName: "pencil.circle.fill")
                        .resizable()
                        .aspectRatio( contentMode: .fit)
                        .frame(width: 250,height: 250)
                    //댓글에 들어가는
                    VStack(alignment: .leading){
                        Text("햄뿡이에욧")
                    }
                    //
                    // 두번쨰
                    //
                    Text("두번째 햄뿡입니다")
                    Image(systemName: "pencil.circle.fill")
                        .resizable()
                        .aspectRatio( contentMode: .fit)
                        .frame(width: 250,height: 250)
                    //댓글에 들어가는
                    VStack(alignment: .leading){
                        Text("두번째 햄뿡이에욧")
                    }
                    //
                    // 세번쨰
                    //
                    Text("세번째 햄뿡입니다")
                    Image(systemName: "pencil.circle.fill")
                        .resizable()
                        .aspectRatio( contentMode: .fit)
                        .frame(width: 250,height: 250)
                    //댓글에 들어가는
                    VStack(alignment: .leading){
                        Text("세번째 햄뿡이에욧")
                    }
                }
                    
            }
            
            
        }
        .padding()
    }
}

struct PrototypeFeedView_Previews: PreviewProvider {
    static var previews: some View {
        PrototypeFeedView()
    }
}
