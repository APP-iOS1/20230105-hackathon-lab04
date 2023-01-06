//
//  SplashView.swift
//  lab04-hackathon
//
//  Created by Park Jungwoo on 2023/01/06.
//

import SwiftUI

struct SplashView: View {
    @State private var isActive = false
    
    var body: some View {
        
        if isActive {
            LoginView()
        } else {
            Lottie(filename: "lottie2")
                .background(Color("background"))
                .edgesIgnoringSafeArea(.all)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.7) {
                        self.isActive = true
                    }
                }
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
