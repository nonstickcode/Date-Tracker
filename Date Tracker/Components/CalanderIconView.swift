//
//  CalanderIconView.swift
//  Date Tracker
//
//  Created by Cody McRoy on 9/10/23.
//

import SwiftUI

struct CalendarIconView: View {
    var month: String
    var day: String
    
    var body: some View {
        ZStack(alignment: .top) {
            // Main rectangle (white)
            Rectangle()
                .foregroundColor(.white)
                .frame(width: 30, height: 30)
                .overlay(
                    Rectangle()
                        .stroke(Color.gray, lineWidth: 1)
                )
            
            // Top bar (red), taking up 40% of the height
            Rectangle()
                .foregroundColor(.pink.opacity(0.9))
                .frame(width: 30, height: 12)
                .overlay(
                    Text(month)
                        .foregroundColor(.white)
                        .font(.system(size: 10))
                        .bold()
                )
            
            // Day label (black)
            Text(day)
                .foregroundColor(.black)
                .font(.headline)
                .fontWeight(.bold)
                .offset(y: 11)
        }
    }
}

struct CalendarIconView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarIconView(month: "SEP", day: "10")
    }
}
