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
            .foregroundColor(Color.mainHeaderTextColor)  // foregroundColor is tied to this color variable
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



// Form View Style Below -------------------------------------------


struct FormHeaderStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("Pacifico-Regular", size: 36))
            .foregroundColor(.formHeaderAndSaveButtonForeground)
            .shadow(color: .gray.opacity(0.8), radius: 2, x: 2, y: 2)
    }
}

extension View {
    func formHeaderStyle() -> some View {
        self.modifier(FormHeaderStyle())
    }
}

//------------------------

struct FormRegularStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("Quicksand-Bold", size: 12))
    }
}

extension View {
    func formRegularStyle() -> some View {
        self.modifier(FormRegularStyle())
    }
}

//------------------------

struct FormPlaceholderTextStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("Quicksand-Regular", size: 14))  // unused, cannot figure out how to change TextField style
    }
}

extension View {
    func formPlaceholderTextStyle() -> some View {
        self.modifier(FormPlaceholderTextStyle())
    }
}

//------------------------

struct FormSaveButtonStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("Pacifico-Regular", size: 32))
            .foregroundColor(.formHeaderAndSaveButtonForeground)
            .shadow(color: .gray.opacity(0.8), radius: 2, x: 2, y: 2)
    }
}

extension View {
    func formSaveButtonStyle() -> some View {
        self.modifier(FormSaveButtonStyle())
    }
}

// --------------------------------------------------------------------


