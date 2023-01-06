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
//            LoginView()
            CanvasView()
        } else {
            ZStack {
             
                Text("PENCHAT")
                    .font(.custom("Cafe24Ssurround", size: 34))
                    .offset(y: -110)
                
                Lottie(filename: "lottie2")
                    
            }
                .background(Color("background"))
                .edgesIgnoringSafeArea(.all)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now()) {
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
