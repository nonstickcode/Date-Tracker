//
//  SplashScreenView.swift
//  Date Tracker
//
//  Created by Cody McRoy on 11/4/23.
//

import SwiftUI

struct SplashScreenView: View {
    @State var isActive : Bool = false
    @State private var size = 0.6
    @State private var opacity = 0.5
    
    
    var body: some View {
        ZStack {
            
            Color.black.opacity(0.8).ignoresSafeArea()
            
            VStack {
                VStack {
                    Image(systemName: "figure.martial.arts")
                        .font(.system(size: 150))
                        .foregroundColor(.accentColor)
                    Text("nonstickcode")
                        .font(Font.custom("Pacifico-Regular", size: 48))
                        .foregroundColor(.white)
                }
                .scaleEffect(size)
                .opacity(opacity)
                .onAppear {
                    withAnimation(.easeIn(duration: 2.0)) { // total time SplashScreenView seen determined in @main file
                        self.size = 0.9
                        self.opacity = 1.00
                    }
                }
            }

        }
    }
}


struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
