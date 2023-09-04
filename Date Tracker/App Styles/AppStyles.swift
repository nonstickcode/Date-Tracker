//
//  AppStyles.swift
//  Date Tracker
//
//  Created by Cody McRoy on 9/4/23.
//

import SwiftUI

extension Text {
    
    func headerTopStyle() -> Text {
        self
            .font(.custom("LobsterTwo-Bold", size: 36))
            .foregroundColor(.white)
    }
    
    func footerTextStyle() -> Text {
        self
            .font(.custom("Helvetica", size: 14))
            .foregroundColor(.gray)
    }
}

extension Color {
    static let primaryBlue = Color.blue
    static let secondaryGray = Color.gray
}
