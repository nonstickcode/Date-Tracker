//
//  AppTextStyles.swift
//  Date Tracker
//
//  Created by Cody McRoy on 9/8/23.
//

import SwiftUI




extension Text {
    
    // Content View Style Below -------------------------------------------
    
    func mainHeaderStyle() -> Text {
        self
            .font(.custom("Pacifico-Regular", size: 30))
            .foregroundColor(.mainHeaderTextColor)
    }
    func mainHeaderEditButtonStyle() -> Text {
        self
            .font(.custom("Quicksand-Bold", size: 16))  // not used this style is set manaully
            .foregroundColor(Color.mainHeaderTextColor)
    }
    func mainFooterTextStyle() -> Text {
        self
            .font(.custom("Pacifico-Regular", size: 16))
            .foregroundColor(.mainFooterTextColor)
    }
    
    //--------------------------------------------------------------------
    
    // Detail View Style Below -------------------------------------------
    
    
    func detailViewRegularStyle() -> Text {
        self
            .font(.custom("Quicksand-Regular", size: 16))
            .foregroundColor(.black)
    }
    func detailViewBoldStyle() -> Text {
        self
            .font(.custom("Quicksand-Bold", size: 16))
            .foregroundColor(.accentColor)
    }
    
    // --------------------------------------------------------------------

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
    
    // --------------------------------------------------------------------
    
    
    
    

    
}
