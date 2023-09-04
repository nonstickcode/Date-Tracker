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
            
            if let name = item.name, let eventType = item.eventType, let eventDate = item.eventDate {
                VStack(spacing: 5) {
                    Text("\(name)'s \(eventType) is \(eventDate, formatter: dateFormatter)")
                        .detailViewRegularStyle()
                    
                    let daysUntil = daysUntilEvent(eventDate)
                    
                    if daysUntil == 0 {
                        HStack {
                            Text("Party Time Tomorrow!")
                                .detailViewBoldStyle()
                            Image(systemName: "party.popper")
                                .foregroundColor(.purple)
                                .bold()
                        }
                        
                    } else if daysUntil == 365 {
                        HStack {
                            Text("Party Time Today!")
                                .detailViewBoldStyle()
                            Image(systemName: "party.popper.fill")
                                .foregroundColor(.purple)
                                .bold()
                        }
                        
                    } else {
                        Text("\(name)'s \(eventType) is in \(daysUntil) days")
                            .detailViewRegularStyle()
                    }
                    
                    let yearsSince = yearsSinceEvent(eventDate)
                    
                    if yearsSince > 0 {
                        Text("It will be on a \(dayOfWeek(eventDate)) this year")
                            .detailViewRegularStyle()
                    } else {
                        Text("\(eventDate, formatter: dateFormatter) will be a \(dayOfWeek(eventDate))")
                            .detailViewRegularStyle()
                    }
                    
                    if yearsSince > 0 {
                        Text("Exact age is \(yearsSince) years old!")
                            .detailViewRegularStyle()
                    } else {
                        Text("\(daysUntil) days is exactly \(daysConvertedToYears(daysUntil)) years")
                            .detailViewRegularStyle()
                    }
                    
                    if let timestamp = item.timestamp {
                        Text("Event added to app: \(timestamp, formatter: dateTimeFormatter)")
                            .font(.caption)
                            .padding(.top, 20)
                    }
                    
                    if let id = item.id {
                        Text("ID: \(id)")
                            .font(.caption)
                            .foregroundColor(.blue)
                    }
                    
                }
            } else {
                Text("No data available.")
                    .detailViewRegularStyle()
            }
        }
    }
}



//struct ItemDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        ItemDetailView()
//    }
//}
