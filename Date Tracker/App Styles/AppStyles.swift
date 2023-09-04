//
//  AppStyles.swift
//  Date Tracker
//
//  Created by Cody McRoy on 9/4/23.
//

import SwiftUI

extension Text {
    
    func mainHeaderStyle() -> Text {
        self
            .font(.custom("LobsterTwo-Bold", size: 36))
            .foregroundColor(.mainHeaderTextColor)
    }
    func mainFooterTextStyle() -> Text {
        self
            .font(.custom("RobotoSlab-Regular", size: 16))
            .foregroundColor(.mainFooterTextColor)
    }
    
    //--------------------------------------------------------------------
    
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
    func formHeaderStyle() -> Text {
        self
            .font(.custom("BlackOpsOne-Regular", size: 36))
            .foregroundColor(.formHeaderAndSaveButtonTextColor)
            
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
            .font(.custom("BlackOpsOne-Regular", size: 26))
            .foregroundColor(.formHeaderAndSaveButtonTextColor)
            
    }
    

    //--------------------------------------------------------------------
    
}


extension Color {
    // accentColor is blue
    static let mainHeaderTextColor = Color.white
    static let mainFooterTextColor = Color.white
    static let formHeaderAndSaveButtonTextColor = Color.black
    static let formHeaderAndSaveButton = Color.green.opacity(0.8)
    static let secondaryGray = Color.gray
}
