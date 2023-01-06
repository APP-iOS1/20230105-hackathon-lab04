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
        
        
        ZStack {
            
            Color("background")
                .ignoresSafeArea()
            
            VStack {
                Text("PENCHAT")
                    .font(.cafeLargeTitle)
                    .frame(height: 250)
                    .overlay (
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(.clear)
                    )
                
                ScrollView {
                    VStack(spacing: 30) {
                        HStack {
                            Image("mail")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20)
                                .padding(.leading)
                            TextField("이메일을 입력해주세요", text: $viewModel.email)
                                .font(.cafeHeadline2)
                                .keyboardType(.emailAddress)
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
                                .submitLabel(.go)
                                .onSubmit {
                                    signInWithEmailPassword()
                                }
                        }
                        .frame(width: 380, height: 50)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray, lineWidth: 0.3)
                        )
                        //                    .padding(.vertical, 6)
                        
                        
                        
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
                                    .font(.cafeSubhead2)
                                    .foregroundColor(.black)
                            }
                            .padding()
                        }
                    }
                    
                    Button(action: signInWithEmailPassword) {
                        if viewModel.authenticationState != .authenticating {
                            Text("로그인")
                                .font(.cafeCallout)
                                .foregroundColor(.black)
                        }
                        else {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        }
                    }
                    .disabled(!viewModel.isValid)
                    
                    // Google Sign in
                    //GoogleSignInButton(action: signInWithGoogle)
                    //  .padding(.vertical, 5.0)
                    // ================
                    
                }
                .padding(.bottom, 70)
            }
        }
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
