//
//  AppColors.swift
//  Date Tracker
//
//  Created by Cody McRoy on 9/8/23.
//

import SwiftUI

extension Color {
    // App accentColor = is blue
    static let mainHeaderBackground = Color.black.opacity(0.8)
    static let mainHeaderTextColor = Color.white
    static let mainFooterTextColor = Color.white
    static let formHeaderAndSaveButtonForeground = Color.black
    static let formHeaderAndSaveButtonBackground = Color.green.opacity(0.8)



    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

