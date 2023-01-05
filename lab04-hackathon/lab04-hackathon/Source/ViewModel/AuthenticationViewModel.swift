//
//  AuthenticationViewModel.swift
//  ModooArtist
//
//  Created by 서광현 on 2022/12/13.
//

import Foundation
import FirebaseAuth
import GoogleSignIn
import UIKit

enum AuthenticationState {
    case unauthenticated
    case authenticating
    case authenticated
}

enum AuthenticationFlow {
    case login
    case signUp
}


@MainActor
class AuthenticationViewModel: ObservableObject {
    
    let signInConfig = GIDConfiguration(clientID: "421979927863-b74uslg0g792is9hln73m1tknm07vppd.apps.googleusercontent.com")
    
    @Published var email = ""
    @Published var password = ""
    @Published var confirmPassword = ""
    
    @Published var flow: AuthenticationFlow = .login
    
    @Published var isValid  = false
    @Published var authenticationState: AuthenticationState = .unauthenticated
    @Published var errorMessage = ""
    @Published var user: FirebaseAuth.User?
    @Published var displayName = ""
    
    init() {
        //registerAuthStateHandler()
        
        $flow
            .combineLatest($email, $password, $confirmPassword)
            .map { flow, email, password, confirmPassword in
                flow == .login
                ? !(email.isEmpty || password.isEmpty)
                : !(email.isEmpty || password.isEmpty || confirmPassword.isEmpty)
            }
            .assign(to: &$isValid)
    }
    
    private var authStateHandler: AuthStateDidChangeListenerHandle?
    
    // 로그인상태체크: 한번 로그인했으면, 다시 앱을 실행해도 로그인안해도 됨 | 로그아웃하면 다시 로그인해야함.
    func registerAuthStateHandler() {
        if authStateHandler == nil {
            authStateHandler = Auth.auth().addStateDidChangeListener { auth, user in
                self.user = user
                self.authenticationState = user == nil ? .unauthenticated : .authenticated
                self.displayName = user?.email ?? ""
            }
        }
    }
    
    // 로그인 상태 : 회원가입 혹은 로그인
    func switchFlow() {
        flow = flow == .login ? .signUp : .login
        errorMessage = ""
    }
    

    func reset() {
        flow = .login
        email = ""
        password = ""
        confirmPassword = ""
    }
}

// MARK: - Email and Password Authentication
extension AuthenticationViewModel {
    func signInWithEmailPassword() async -> Bool {
        authenticationState = .authenticating
        do {
            try await Auth.auth().signIn(withEmail: self.email, password: self.password)
            authenticationState = .authenticated
            return true
        }
        catch  {
            print(error)
            errorMessage = error.localizedDescription
            authenticationState = .unauthenticated
            return false
        }
    }
    
    /// google sign in
    ///
    /// - link : [https://blog.codemagic.io/google-sign-in-firebase-authentication-using-swift/](https://blog.codemagic.io/google-sign-in-firebase-authentication-using-swift/)
//    func signInWithGoogle() async -> Bool {
//        if GIDSignIn.sharedInstance.hasPreviousSignIn() {
//            GIDSignIn.sharedInstance.restorePreviousSignIn { [unowned self] user, error in
//                self.authenticateUser(for: user, with: error)
//            }
//            return true
//        } else {
//            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return false }
//            guard let rootViewController = windowScene.windows.first?.rootViewController else { return false }
//
//            GIDSignIn.sharedInstance.signIn(with: signInConfig, presenting: rootViewController) { [unowned self] user, error in
//                return self.authenticateUser(for: user, with: error)
//            }
//            return true
//        }
//    }
    
    
//    private func authenticateUser(for user: GIDGoogleUser?, with error: Error?) {
//        // 1
//        if let error = error {
//            print(error.localizedDescription)
//        }
//
//        // 2
//        guard let authentication = user?.authentication, let idToken = authentication.idToken else { return }
//
//        let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: authentication.accessToken)
//
//        // 3
//        Auth.auth().signIn(with: credential) { [unowned self] (_, error) in
//            if let error = error {
//                print(error.localizedDescription)
//            } else {
//                authenticationState = .unauthenticated
//            }
//        }
//    }
    
    
    func signUpWithEmailPassword() async -> Bool {
        authenticationState = .authenticating
        do  {
            try await Auth.auth().createUser(withEmail: email, password: password)
            return true
        }
        catch {
            print(error)
            errorMessage = error.localizedDescription
            authenticationState = .unauthenticated
            return false
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
        }
        catch {
            print(error)
            errorMessage = error.localizedDescription
        }
    }
    
    func deleteAccount() async -> Bool {
        do {
            try await user?.delete()
            return true
        }
        catch {
            errorMessage = error.localizedDescription
            return false
        }
    }
}
