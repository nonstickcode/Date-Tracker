//
//  ItemButtonView.swift
//  Date Tracker
//
//  Created by Cody McRoy on 9/3/23.
//

import SwiftUI
import CoreData

struct ItemButtonView: View {
    var item: Item?
    
    var body: some View {
        RoundedRectangle(cornerRadius: 8)
            .fill(Color.white)
            .frame(height: 60)
            .overlay(
                VStack(alignment: .leading, spacing: 3) {
                    if let item = item {
                        Text("\(item.name ?? "Unknown")'s \(item.eventType ?? "Unknown") is in \(daysUntilEvent(item.eventDate)) days")
                        Text("\(dayOfWeek(item.eventDate) ) \(item.eventDate.map { dateFormatter.string(from: $0) } ?? "Unknown")")
                    } else {
                        Text("No data available.")
                        Text("Tap + to add new event.")
                    }
                }
                
            )
            .padding(.top, 8)
            .padding([.leading, .trailing], 16)
    }
}
