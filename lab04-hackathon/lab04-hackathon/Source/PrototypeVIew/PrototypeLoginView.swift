//
//  PrototypeLoginView.swift
//  lab04-hackathon
//
//  Created by 지정훈 on 2023/01/05.
//

import SwiftUI

struct PrototypeLoginView: View {
    @State var id : String = ""
    @State var pass : String = ""
    var body: some View {
        VStack{
            TextField("로그인", text:$id)
            // 비밀번호 시큐어로 바꾸기
            TextField("비밀번호", text:$pass)
            HStack{
                Button {
                    // 로그인 이동
                } label: {
                    Text("로그인")
                }
                Spacer()
                Button {
                        //회원 가입으로 이동
                } label: {
                    Text("회원가입")
                }

            }.padding()
        }
        
    }
}

struct PrototypeLoginView_Previews: PreviewProvider {
    static var previews: some View {
        PrototypeLoginView()
    }
}
