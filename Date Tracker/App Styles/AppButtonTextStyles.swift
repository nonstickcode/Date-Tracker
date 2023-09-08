//
//  AppButtonTextStyles.swift
//  Date Tracker
//
//  Created by Cody McRoy on 9/8/23.
//

import SwiftUI




// Main List / Buttons Style Below -------------------------------------------



//------------------------

struct MainButtonTextStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("Quicksand-Regular", size: 16))
            .foregroundColor(.accentColor)
            .padding(.leading, 10)
            .padding(.trailing, 10)
    }
}

extension View {
    func mainButtonTextStyle() -> some View {
        self.modifier(MainButtonTextStyle())
    }
}

//------------------------

struct BoldButtonTextStyle: ViewModifier {
    public func body(content: Content) -> some View {
        content
            .font(.custom("Quicksand-Bold", size: 16))
            .foregroundColor(.accentColor)
            .padding(.leading, 10)
            .padding(.trailing, 10)
    }
}

extension View {
    func boldButtonTextStyle() -> some View {
        self.modifier(BoldButtonTextStyle())
    }
}

//------------------------

struct BoldButtonRedTextStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("Quicksand-Bold", size: 16))
            .foregroundColor(.red)
            .padding(.leading, 10)
            .padding(.trailing, 10)
    }
}

extension View {
    func boldButtonRedTextStyle() -> some View {
        self.modifier(BoldButtonRedTextStyle())
    }
}

//------------------------

struct EmptyButtonTextStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("Quicksand-Regular", size: 16))
            .foregroundColor(.black)
            .padding(.leading, 10)
            .padding(.trailing, 10)
    }
}

extension View {
    func emptyButtonTextStyle() -> some View {
        self.modifier(EmptyButtonTextStyle())
    }
}

//------------------------

struct EmptyButtonBoldTextStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("Quicksand-Bold", size: 16))
            .foregroundColor(.black)
            .padding(.leading, 10)
            .padding(.trailing, 10)
    }
}

extension View {
    func emptyButtonBoldTextStyle() -> some View {
        self.modifier(EmptyButtonBoldTextStyle())
    }
}

//------------------------



// ------------------------------------------------------------------
