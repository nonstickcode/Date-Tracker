//
//  ItemDetailView.swift
//  Date Tracker
//
//  Created by Cody McRoy on 9/4/23.
//

import SwiftUI

struct ItemDetailView: View {
    var item: Item
    
    var body: some View {
        VStack {
            
            VStack(spacing: 5) {
                Text("\(item.name!)'s \(item.eventType!) is \(item.eventDate!, formatter: dateFormatter)")
                
                if daysUntilEvent(item.eventDate!) == 0 {
                    HStack {
                        Text("Party Time Tomorrow!")
                        Image(systemName: "party.popper")
                    }
                    .bold()
                } else if daysUntilEvent(item.eventDate!) == 365 {
                    HStack {
                        Text("Party Time Today!")
                        Image(systemName: "party.popper.fill")
                    }
                    .bold()
                } else {
                    Text("\(item.name ?? "Unknown")'s \(item.eventType ?? "Unknown") is in \(daysUntilEvent(item.eventDate)) days")
                }
                
                if yearsSinceEvent(item.eventDate) > 0 {
                    Text("It will be on a \(dayOfWeek(item.eventDate)) this year")
                } else {
                    Text("\(item.eventDate!, formatter: dateFormatter) will be a \(dayOfWeek(item.eventDate))")
                }
                
                if yearsSinceEvent(item.eventDate) > 0 {
                    Text("Exact age is \(yearsSinceEvent(item.eventDate)) years old!")
                } else {
                    Text("\(daysUntilEvent(item.eventDate)) days is exactly \(daysConvertedToYears(daysUntilEvent(item.eventDate))) years")
                }
                Text("Event added to app: \(item.timestamp!, formatter: dateTimeFormatter)")
                    .font(.caption)
                    .padding(.top, 20)
                Text("ID: \(item.id!)")
                    .font(.caption)
                    .foregroundColor(.blue)
                
            }
        }
    }
}


//struct ItemDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        ItemDetailView()
//    }
//}
