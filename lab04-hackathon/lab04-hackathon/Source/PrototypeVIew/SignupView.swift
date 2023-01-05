//
//  SignupView.swift
//  ModooArtist
//
//  Created by 서광현 on 2022/12/13.
//

import SwiftUI
import Combine
//import FirebaseAnalyticsSwift

private enum FocusableField: Hashable {
    case userName
    case email
    case password
    case confirmPassword
}

struct SignupView: View {
    @EnvironmentObject var viewModel: AuthenticationViewModel
    @Environment(\.dismiss) var dismiss
    
    @FocusState private var focus: FocusableField?
    
    //유저네임 통신해서 데이터 쓰기 작업필요
    //목업용 유저네임 프로퍼티
    @State private var userName = ""
    
    private func signUpWithEmailPassword() {
        Task {
            if await viewModel.signUpWithEmailPassword() == true {
                dismiss()
            }
        }
    }
    
    var body: some View {
        VStack{
            Text("PENCHAT")
                .padding(.bottom,50)
                .font(.title)
            
            VStack{
                HStack {
                    Image(systemName: "person")
                    TextField("별명을 입력해주세요", text: $userName)
                        .textInputAutocapitalization(.never)
                        .disableAutocorrection(true)
                        .focused($focus, equals: .userName)
                        .submitLabel(.next)
                        .onSubmit {
                            self.focus = .email
                        }
                }
                .padding(.vertical, 6)
                .background(Divider(), alignment: .bottom)
                .padding(.bottom, 4)
                
                HStack {
                    Image(systemName: "at")
                    TextField("이메일을 입력해주세요", text: $viewModel.email)
                        .textInputAutocapitalization(.never)
                        .disableAutocorrection(true)
                        .focused($focus, equals: .email)
                        .submitLabel(.next)
                        .onSubmit {
                            self.focus = .password
                        }
                }
                .padding(.vertical, 6)
                .background(Divider(), alignment: .bottom)
                .padding(.bottom, 4)
                
                HStack {
                    Image(systemName: "lock")
                    SecureField("비밀번호를 입력해주세요", text: $viewModel.password)
                        .focused($focus, equals: .password)
                        .submitLabel(.next)
                        .onSubmit {
                            self.focus = .confirmPassword
                        }
                }
                .padding(.vertical, 6)
                .background(Divider(), alignment: .bottom)
                .padding(.bottom, 8)
                
                HStack {
                    Image(systemName: "lock")
                    SecureField("비밀번호를 한번 더 입력해주세요", text: $viewModel.confirmPassword)
                        .focused($focus, equals: .confirmPassword)
                        .submitLabel(.go)
                        .onSubmit {
                            signUpWithEmailPassword()
                        }
                }
                .padding(.vertical, 6)
                .background(Divider(), alignment: .bottom)
                .padding(.bottom, 8)
            }
            .padding(.top,50)
            
            if !viewModel.errorMessage.isEmpty {
                VStack {
                    Text(viewModel.errorMessage)
                        .foregroundColor(Color(UIColor.systemRed))
                }
            }
            
            HStack {
                Spacer()
                Text("계정이 있으신가요?")
                Button(action: { viewModel.switchFlow() }) {
                    Text("로그인")
                        .fontWeight(.semibold)
                        .foregroundColor(.blue)
                }
            }
            
            
            Button(action: signUpWithEmailPassword) {
                if viewModel.authenticationState != .authenticating {
                    Text("회원가입")
                        .font(.title)
                        .padding(.vertical, 8)
                        //.frame(maxWidth: .infinity)
                        //.foregroundColor(.primary)
                }
                else {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        .padding(.vertical, 8)
                        //.frame(maxWidth: .infinity)
                }
            }
            .disabled(!viewModel.isValid)
            
            Spacer()
        }
        .listStyle(.plain)
        .frame(height: 500)
        .padding()
        //.analyticsScreen(name: "\(Self.self)")
    }
}

struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SignupView()
            //SignupView()
              //  .preferredColorScheme(.dark)
        }
        .environmentObject(AuthenticationViewModel())
    }
}
