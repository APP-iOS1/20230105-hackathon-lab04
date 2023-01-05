//
//  AuthenticatedView.swift
//  ModooArtist
//
//  Created by 서광현 on 2022/12/13.
//

import SwiftUI

// see https://michael-ginn.medium.com/creating-optional-viewbuilder-parameters-in-swiftui-views-a0d4e3e1a0ae
extension AuthenticatedView where Unauthenticated == EmptyView {
    init(@ViewBuilder content: @escaping () -> Content) {
        self.unauthenticated = nil
        self.content = content
    }
}

struct AuthenticatedView<Content, Unauthenticated>: View where Content: View, Unauthenticated: View {
    @EnvironmentObject var viewModel: AuthenticationViewModel
    //@State private var presentingLoginScreen = false
   // @State private var presentingProfileScreen = false
    
    var unauthenticated: Unauthenticated?
    @ViewBuilder var content: () -> Content
    
    public init(unauthenticated: Unauthenticated?, @ViewBuilder content: @escaping () -> Content) {
        self.unauthenticated = unauthenticated
        self.content = content
    }
    
    public init(@ViewBuilder unauthenticated: @escaping () -> Unauthenticated, @ViewBuilder content: @escaping () -> Content) {
        self.unauthenticated = unauthenticated()
        self.content = content
    }
    
    
    var body: some View {
        switch viewModel.authenticationState {
        case .unauthenticated, .authenticating:
            VStack {
                AuthenticationView()
                    .environmentObject(viewModel)
            }
            //.padding(.horizontal ,32.0)
//            .sheet(isPresented: $presentingLoginScreen) {
//                AuthenticationView()
//                    .environmentObject(viewModel)
//            }
            case .authenticated:
            VStack {
                content()
            }
//            .sheet(isPresented: $presentingProfileScreen) {
//                NavigationView {
//                    UserProfileView()
//                        .environmentObject(viewModel)
//                }
//            }
        }
    }
}

//struct AuthenticatedView_Previews: PreviewProvider {
//    static var previews: some View {
//        AuthenticatedView {
//            Text("You're signed in.")
//                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
//                .background(.yellow)
//        }
//    }
//}
