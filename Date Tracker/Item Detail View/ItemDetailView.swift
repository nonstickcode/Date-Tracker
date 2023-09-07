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
                    
                    // Line 1 of Text in view --------------------------------------------------------
                    
                    Text("\(name)'s \(eventType) is \(eventDate, formatter: dateFormatter)")
                        .detailViewRegularStyle()
                    
                    // Line 2 of Text in view --------------------------------------------------------
                    
                    let daysUntil = daysUntilEvent(eventDate)
                    
                    if daysUntil == 365 && (eventType == "Birthday" || eventType == "Anniversary") {
                        HStack {
                            Text("\(name)'s \(eventType) was yesterday!")
                                .detailViewBoldStyle()
                            Image(systemName: "figure.wave.circle")
                                .foregroundColor(.brown)
                                .bold()
                        }
                        
                    } else if daysUntil == 365 && (eventType == "Vacation" || eventType == "Holiday") {
                        HStack {
                            Text("\(name)'s \(eventType) was yesterday!")
                                .detailViewBoldStyle()
                            Image(systemName: "figure.wave.circle.fill")
                                .foregroundColor(.brown)
                                .bold()
                        }
                        
                    } else if daysUntil == 0 && (eventType == "Birthday" || eventType == "Anniversary") {
                        HStack {
                            Text("Party Time Today!")
                                .detailViewBoldStyle()
                            Image(systemName: "party.popper.fill")
                                .foregroundColor(.purple)
                                .bold()
                        }
                        
                    } else if daysUntil == 0 && (eventType == "Vacation" || eventType == "Holiday") {
                        HStack {
                            Text("\(name) is Today!")
                                .detailViewBoldStyle()
                            Image(systemName: "calendar.badge.exclamationmark")
                                .foregroundColor(.purple)
                                .bold()
                        }
                        
                    } else if daysUntil == 1 && (eventType == "Birthday" || eventType == "Anniversary") {
                        HStack {
                            Text("Party Time Tomorrow!")
                                .detailViewBoldStyle()
                            Image(systemName: "party.popper")
                                .foregroundColor(.purple)
                                .bold()
                        }
                        
                    } else if daysUntil == 1 && (eventType == "Vacation" || eventType == "Holiday") {
                        HStack {
                            Text("\(name) is Tomorrow!")
                                .detailViewBoldStyle()
                            Image(systemName: "calendar.badge.clock")
                                .foregroundColor(.purple)
                                .bold()
                        }
                        
                        
                    } else {
                        Text("\(name)'s \(eventType) is in \(daysUntil) days")
                            .detailViewRegularStyle()
                    }
                    
                    // Line 3 of Text in view --------------------------------------------------------
                    
                    let yearsSince = yearsSinceEvent(eventDate)
                    
                    if yearsSince > 0 {
                        Text("It will be on a \(dayOfWeek(eventDate)) this year")
                            .detailViewRegularStyle()
                    } else {
                        Text("\(eventDate, formatter: dateFormatter) will be a \(dayOfWeek(eventDate))")
                            .detailViewRegularStyle()
                    }
                    
                    // Line 4 of Text in view --------------------------------------------------------
                    
                    if yearsSince > 0 {
                        Text("Exact age is \(yearsSince) years old!")
                            .detailViewRegularStyle()
                    } else {
                        Text("\(daysUntil) days is exactly \(daysConvertedToYears(daysUntil)) years")
                            .detailViewRegularStyle()
                    }
                    
                    // Line 5 of Text in view --------------------------------------------------------
                    
                    if let timestamp = item.timestamp {
                        Text("Event added to app: \(timestamp, formatter: dateTimeFormatter)")
                            .font(.caption)
                            .padding(.top, 20)
                    }
                    
                    // Line 6 of Text in view --------------------------------------------------------
                    
                    if let id = item.id {
                        Text("ID: \(id)")
                            .font(.caption)
                            .foregroundColor(.blue)
                    }
                    
                    // End of Detailed view --------------------------------------------------------
                    
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
