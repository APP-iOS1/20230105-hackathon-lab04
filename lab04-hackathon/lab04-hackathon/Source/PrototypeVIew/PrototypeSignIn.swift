//
//  PrototypeSignIn.swift
//  lab04-hackathon
//
//  Created by 지정훈 on 2023/01/05.
//

import SwiftUI

struct PrototypeSignIn: View {
    @State var idInput : String = ""
    @State var pass1Input : String = ""
    @State var pass2Input : String = ""
    var body: some View {
        VStack{
            TextField("아이디 입력", text:$idInput)
            TextField("비밀번호1 입력", text:$pass1Input)
            TextField("비밃번호2 입력", text:$pass2Input)
            
            HStack{
                Button {
                        //회원 가입으로 이동
                } label: {
                    Text("회원가입")
                }

            }.padding()
        }
       
    }
}

struct PrototypeSignIn_Previews: PreviewProvider {
    static var previews: some View {
        PrototypeSignIn()
    }
}
