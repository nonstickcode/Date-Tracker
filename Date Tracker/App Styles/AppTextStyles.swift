//
//  AppTextStyles.swift
//  Date Tracker
//
//  Created by Cody McRoy on 9/8/23.
//

import SwiftUI






// Content View Style Below -------------------------------------------

struct MainHeaderStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("Pacifico-Regular", size: 30))
            .foregroundColor(.mainHeaderTextColor)
            .padding(.leading, 10)
            .padding(.trailing, 10)
    }
}

extension View {
    func mainHeaderStyle() -> some View {
        self.modifier(MainHeaderStyle())
    }
}

//------------------------

struct MainHeaderEditButtonStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("Quicksand-Bold", size: 16))  // not used this style is set manaully
            .foregroundColor(Color.mainHeaderTextColor)
            .padding(.leading, 10)
            .padding(.trailing, 10)
    }
}

extension View {
    func mainHeaderEditButtonStyle() -> some View {
        self.modifier(MainHeaderEditButtonStyle())
    }
}

//------------------------

struct MainFooterTextStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("Pacifico-Regular", size: 16))
            .foregroundColor(.mainFooterTextColor)
            .padding(.leading, 10)
            .padding(.trailing, 10)
    }
}

extension View {
    func mainFooterTextStyle() -> some View {
        self.modifier(MainFooterTextStyle())
    }
}

//------------------------

//--------------------------------------------------------------------

// Detail View Style Below -------------------------------------------

struct DetailViewRegularStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("Quicksand-Regular", size: 16))
            .foregroundColor(.black)
            .padding(.leading, 10)
            .padding(.trailing, 10)
            .lineSpacing(2)
    }
}

extension View {
    func detailViewRegularStyle() -> some View {
        self.modifier(DetailViewRegularStyle())
    }
}

//------------------------

struct DetailViewBoldStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("Quicksand-Bold", size: 16))
            .foregroundColor(.accentColor)
            .padding(.leading, 10)
            .padding(.trailing, 10)
            .lineSpacing(2)
    }
}

extension View {
    func detailViewBoldStyle() -> some View {
        self.modifier(DetailViewBoldStyle())
    }
}

// --------------------------------------------------------------------

extension Text {
    
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
