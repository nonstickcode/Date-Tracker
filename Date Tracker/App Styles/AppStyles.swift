//
//  AppStyles.swift
//  Date Tracker
//
//  Created by Cody McRoy on 9/4/23.
//

import SwiftUI

extension Text {
    
    // Content View Style Below -------------------------------------------
    
    func mainHeaderStyle() -> Text {
        self
            .font(.custom("LobsterTwo-Bold", size: 36))
            .foregroundColor(.mainHeaderTextColor)
    }
    func mainHeaderEditButtonStyle() -> Text {
        self
            .font(.custom("Roboto-Regular", size: 16))  // not used this style is set manaully
            .foregroundColor(Color.mainHeaderTextColor)
    }
    func mainFooterTextStyle() -> Text {
        self
            .font(.custom("RobotoSlab-Regular", size: 16))
            .foregroundColor(.mainFooterTextColor)
    }
    
    //--------------------------------------------------------------------
    
    // Main List / Buttons Style Below -------------------------------------------
    
    func mainButtonTextStyle() -> Text {
        self
            .font(.custom("Roboto-Regular", size: 16))
            .foregroundColor(.accentColor)
    }
    func boldButtonTextStyle() -> Text {
        self
            .font(.custom("Roboto-Bold", size: 16))
            .foregroundColor(.accentColor)
    }
    func emptyButtonTextStyle() -> Text {
        self
            .font(.custom("Roboto-Regular", size: 16))
            .foregroundColor(.black)
    }
    
    // ------------------------------------------------------------------
    
    // Form View Style Below -------------------------------------------
    
    func formHeaderStyle() -> Text {
        self
            .font(.custom("BlackOpsOne-Regular", size: 36))
            .foregroundColor(.formHeaderAndSaveButtonForeground)
    }
    func formRegularStyle() -> Text {
        self
            .font(.custom("RobotoMono-Bold", size: 12))
    }
    func formItalicsStyle() -> Text {
        self
            .font(.custom("RobotoMono-Italic", size: 14))  // unused, cannot figure out how to change TextField style other than .font(.custom("RobotoMono-Italic", size: 16))
    }
    func formSaveButtonStyle() -> Text {
        self
            .font(.custom("BlackOpsOne-Regular", size: 32))
            .foregroundColor(.formHeaderAndSaveButtonForeground)
    }
    
    //--------------------------------------------------------------------
    
    // Detail View Style Below -------------------------------------------
    
    
    func detailViewRegularStyle() -> Text {
        self
            .font(.custom("Roboto-Regular", size: 20))
            .foregroundColor(.black)
    }
    func detailViewBoldStyle() -> Text {
        self
            .font(.custom("Roboto-Bold", size: 20))
            .foregroundColor(.accentColor)
    }
    
    // --------------------------------------------------------------------
    
}

// Custom Colors Below -------------------------------------------

extension Color {
    // App accentColor = is blue
    static let mainHeaderBackground = Color.black.opacity(0.8)
    static let mainHeaderTextColor = Color.white
    static let mainFooterTextColor = Color.white
    static let formHeaderAndSaveButtonForeground = Color.black
    static let formHeaderAndSaveButtonBackground = Color.green.opacity(0.8)
}

extension View {
    func mainGradientBackground() -> some View {
        self.background(
            LinearGradient(
                gradient: Gradient(colors: [Color.green, Color.accentColor]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
    }
}
