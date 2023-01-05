//
//  LoginView.swift
//  ModooArtist
//
//  Created by 서광현 on 2022/12/13.
//

import SwiftUI
import Combine
import GoogleSignInSwift
import GoogleSignIn

private enum FocusableField: Hashable {
    case email
    case password
}

struct LoginView: View {
    @EnvironmentObject var viewModel: AuthenticationViewModel
    @Environment(\.dismiss) var dismiss
    
    @FocusState private var focus: FocusableField?
    
    
    private func signInWithEmailPassword() {
        Task {
            if await viewModel.signInWithEmailPassword() == true {
                dismiss()
            }
        }
    }
    
    //    private func signInWithGoogle() {
    //        Task {
    //            if await viewModel.signInWithGoogle() {
    //                dismiss()
    //            }
    //        }
    //    }
    
    var body: some View {
        VStack {
            Text("PENCHAT")
                .padding(.bottom,50)
                .font(.title)
            
            
            VStack{
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
                        .submitLabel(.go)
                        .onSubmit {
                            signInWithEmailPassword()
                        }
                }
                .padding(.vertical, 6)
                .background(Divider(), alignment: .bottom)
                .padding(.bottom, 8)
                
                if !viewModel.errorMessage.isEmpty {
                    VStack {
                        Text(viewModel.errorMessage)
                            .foregroundColor(Color(UIColor.systemRed))
                    }
                }
                
                HStack {
                    Spacer()
                    //Text("계정이 없으신가요?")
                    Button(action: { viewModel.switchFlow() }) {
                        Text("회원가입")
                            .fontWeight(.semibold)
                        //.foregroundColor(.blue)
                    }
                }
            }
            
            Button(action: signInWithEmailPassword) {
                if viewModel.authenticationState != .authenticating {
                    Text("로그인")
                        .padding(.vertical, 8)
                        .font(.title)
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
            //.frame(maxWidth: .infinity)
            //.buttonStyle(.borderedProminent)
            //.padding(.vertical, 10.0)
            
            // Google Sign in
            //GoogleSignInButton(action: signInWithGoogle)
            //  .padding(.vertical, 5.0)
            // ================
            Spacer()
        }
        .listStyle(.plain)
        .frame(height: 500)
        .padding()
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LoginView()
            //LoginView()
              //  .preferredColorScheme(.dark)
        }
        .environmentObject(AuthenticationViewModel())
    }
}
