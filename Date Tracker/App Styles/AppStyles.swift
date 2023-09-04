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
            
    }
    func mainFooterTextStyle() -> Text {
        self
            .font(.custom("Helvetica", size: 14))
            .foregroundColor(.gray)
    }
    
    //--------------------------------------------------------------------
    
    func formHeaderStyle() -> Text {
        self
            .font(.custom("BlackOpsOne-Regular", size: 36))
            
    }
    func formRegularStyle() -> Text {
        self
            .font(.custom("RobotoMono-Bold", size: 12))
            
    }
    func formItalicsStyle() -> Text {
        self
            .font(.custom("RobotoMono-Italic", size: 14))
            
    }
    func formSaveButtonStyle() -> Text {
        self
            .font(.custom("BlackOpsOne-Regular", size: 26))
            
    }
    

    //--------------------------------------------------------------------
    
}


extension Color {
    static let mainHeaderTextColor = Color.white
    static let mainFooterTextColor = Color.white
    static let formHeaderAndSaveButtonTextColor = Color.black
    static let formHeaderAndSaveButton = Color.green.opacity(0.8)
    static let primaryBlue = Color.blue
    static let secondaryGray = Color.gray
}
