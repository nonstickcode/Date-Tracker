//
//  AppViewModifiers.swift
//  Date Tracker
//
//  Created by Cody McRoy on 9/8/23.
//

import SwiftUI


// Main Gradient used in background

extension View {
    func mainGradientBackground() -> some View {
        self.background(
            LinearGradient(
                gradient: Gradient(colors: [Color.green, Color.accentColor, Color.green]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
    }
}
