//
//  SignupView.swift
//  ModooArtist
//
//  Created by 서광현 on 2022/12/13.
//

import SwiftUI
import Combine
//import FirebaseAnalyticsSwift
import FirebaseAuth

private enum FocusableField: Hashable {
    case userName
    case email
    case password
    case confirmPassword
}

struct SignupView: View {
    @EnvironmentObject var viewModel: AuthenticationViewModel
    @EnvironmentObject var userVm: UserStore
    @Environment(\.dismiss) var dismiss
    
    @FocusState private var focus: FocusableField?
    
    //유저네임 통신해서 데이터 쓰기 작업필요
    //목업용 유저네임 프로퍼티
    @State private var userName = ""
    
    private func signUpWithEmailPassword() {
        Task {
            if await viewModel.signUpWithEmailPassword() == true {
                userVm.createUserData(uid: FirebaseAuth.Auth.auth().currentUser?.uid ?? "", userName: userName)
                dismiss()
            }
        }
    }
    
    var body: some View {
        
        ZStack {
            
            Color("background")
                .ignoresSafeArea()
            
            VStack {
                Text("PENCHAT")
                    .font(.cafeLargeTitle)
                    .padding(.bottom, 80)
                
                VStack(spacing: 30) {
                    HStack {
                        Image("person2")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20)
                            .padding(.leading)
                        TextField("별명을 입력해주세요", text: $userName)
                            .font(.cafeHeadline2)
                            .textInputAutocapitalization(.never)
                            .disableAutocorrection(true)
                            .focused($focus, equals: .userName)
                            .submitLabel(.next)
                            .onSubmit {
                                self.focus = .email
                            }
                    }
                    .frame(width: 380, height: 50)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray, lineWidth: 0.3)
                    )
                    
                    
                    HStack {
                        Image("mail")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20)
                            .padding(.leading)
                        TextField("이메일을 입력해주세요", text: $viewModel.email)
                            .font(.cafeHeadline2)
                            .textInputAutocapitalization(.never)
                            .disableAutocorrection(true)
                            .focused($focus, equals: .email)
                            .submitLabel(.next)
                            .onSubmit {
                                self.focus = .password
                            }
                    }
                    .frame(width: 380, height: 50)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray, lineWidth: 0.3)
                    )
                    
                    HStack {
                        Image("lock")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20)
                            .padding(.leading)
                        SecureField("비밀번호를 입력해주세요", text: $viewModel.password)
                            .font(.cafeHeadline2)
                            .focused($focus, equals: .password)
                            .submitLabel(.next)
                            .onSubmit {
                                self.focus = .confirmPassword
                            }
                    }
                    .frame(width: 380, height: 50)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray, lineWidth: 0.3)
                    )
                    
                    HStack {
                        Image("lock")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20)
                            .padding(.leading)
                        SecureField("비밀번호를 한번 더 입력해주세요", text: $viewModel.confirmPassword)
                            .font(.cafeHeadline2)
                            .focused($focus, equals: .confirmPassword)
                            .submitLabel(.go)
                            .onSubmit {
                                signUpWithEmailPassword()
                            }
                    }
                    .frame(width: 380, height: 50)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray, lineWidth: 0.3)
                    )
                }
                
                if !viewModel.errorMessage.isEmpty {
                    VStack {
                        Text(viewModel.errorMessage)
                            .foregroundColor(Color(UIColor.systemRed))
                    }
                }
                
                VStack(spacing: 60) {
                    HStack {
                        Spacer()
                        Text("계정이 있으신가요?")
                            .font(.cafeCaption2)
                            .foregroundColor(.black)
                        Button(action: { viewModel.switchFlow() }) {
                            Text("로그인")
                                .font(.cafeSubhead2)
                                .foregroundColor(.black)
                        }
                        .padding(.trailing)
                    }
                    
                    Button(action: signUpWithEmailPassword) {
                        if viewModel.authenticationState != .authenticating {
                            Text("회원가입")
                                .font(.cafeCallout)
                                .foregroundColor(.black)
                        }
                        else {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        }
                    }
                    .disabled(!viewModel.isValid)
                }
                
            }
            //.analyticsScreen(name: "\(Self.self)")
        }
    }
}

struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SignupView()
            //SignupView()
            //  .preferredColorScheme(.dark)
        }
        .environmentObject(AuthenticationViewModel()).environmentObject(UserStore())
    }
}
