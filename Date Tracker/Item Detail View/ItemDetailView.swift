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
            
            if let eventDate = item.eventDate {
                VStack(spacing: 5) {
                    
                    let firstLine = detailsFirstLine(for: item, on: eventDate)
                    let secondLine = detailsSecondLine(for: item, on: eventDate)
                    let thirdLine = detailsThirdLine(for: item, on: eventDate)
                    let fourthLine = detailsFourthLine(for: item, on: eventDate)
                    
                    // Line 1 of Text in view --------------------------------------------------------
                    
                    HStack {
                        Text(firstLine.text)
                            .detailViewRegularStyle()
                        firstLine.imageView
                    }
                    
                    // Line 2 of Text in view --------------------------------------------------------
                    
                    HStack {
                        Text(secondLine.text)
                            .detailViewBoldStyle()
                        secondLine.imageView
                    }
                    
                    // Line 3 of Text in view --------------------------------------------------------
                    
                    HStack {
                        Text(thirdLine.text)
                            .detailViewRegularStyle()
                        thirdLine.imageView
                    }
                    
                    // Line 4 of Text in view --------------------------------------------------------
                    
                    HStack {
                        Text(fourthLine.text)
                            .detailViewRegularStyle()
                        fourthLine.imageView
                    }
                    
                    // Line 5 of Text in view ------------------------optional--------------------------------
                    
                    if item.taggedForDelete == true, let dateEventTaggedForDelete = item.dateEventTaggedForDelete {
                        Text("DELETED: \(dateEventTaggedForDelete, formatter: dateTimeFormatter)")
                            .bold()
                            .font(.caption)
                            .foregroundColor(.red)
                            .padding(5)
                    }

                    // Line 6 of Text in view -------------------------optional-------------------------------

                    if item.taggedForDelete == true {
                        Text("\(item.timeUntilHardDelete) days until HARD Deleted")
                            .bold()
                            .font(.caption)
                            .foregroundColor(.red)
                            .padding(5)
                    }

                    
                    // Line 7 of Text in view --------------------------------------------------------
                    
                    if let timestamp = item.timestamp {
                        Text("Event added to app: \(timestamp, formatter: dateTimeFormatter)")
                            .font(.caption)
                            .padding(5)
                    }
                    
                    // Line 8 of Text in view --------------------------------------------------------
                    
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
    
    
    
    private func detailsFirstLine(for item: Item, on eventDate: Date) -> ButtonContent {
        let name = item.name ?? "Unknown"
        let eventType = item.eventType ?? "Unknown"
        
        let dateFormatterString = dateFormatter.string(from: eventDate)  // always want to show the year in the date on first line of details view
        
        
        return ButtonContent (text: "\(name)'s \(eventType) is \(dateFormatterString)", imageView: AnyView(EmptyView()))
    }
    
    
    private func detailsSecondLine(for item: Item, on eventDate: Date) -> ButtonContent {
        let name = item.name ?? "Unknown"
        let eventType = item.eventType ?? "Unknown"
        let daysUntil = daysUntilEvent(eventDate)
        
        if daysUntil == 365 && (eventType == "Birthday" || eventType == "Anniversary") {
            return ButtonContent (text: "\(name)'s \(eventType) was yesterday!", imageView:  AnyView(Image(systemName: "figure.wave.circle").foregroundColor(.brown)))
        } else if daysUntil == 365 && (eventType == "Holiday" || eventType == "Vacation") {
            return ButtonContent (text: "\(name)'s \(eventType) was yesterday!", imageView: AnyView(Image(systemName: "figure.wave.circle.fill").foregroundColor(.brown)))
        } else if daysUntil == 0 && (eventType == "Birthday" || eventType == "Anniversary") {
            return ButtonContent (text: "Party Time Today!", imageView: AnyView(Image(systemName: "party.popper.fill").foregroundColor(.purple)))
        } else if daysUntil == 0 && (eventType == "Holiday" || eventType == "Vacation") {
            return ButtonContent (text: "\(name)'s \(eventType) is Today!", imageView: AnyView(Image(systemName: "calendar.badge.exclamationmark").foregroundColor(.purple)))
        } else if daysUntil == 1 && (eventType == "Birthday" || eventType == "Anniversary") {
            return ButtonContent (text: "Party Time Tomorrow!", imageView: AnyView(Image(systemName: "party.popper").foregroundColor(.purple)))
        } else if daysUntil == 1 && (eventType == "Holiday" || eventType == "Vacation") {
            return ButtonContent (text: "\(name) is Tomorrow!", imageView: AnyView(Image(systemName: "calendar.badge.clock").foregroundColor(.purple)))
        } else {
            return ButtonContent (text: "This event is in \(daysUntil) days", imageView: AnyView(EmptyView()))
        }
    }
    
    
    private func detailsThirdLine(for item: Item, on eventDate: Date) -> ButtonContent {
        let yearsSince = yearsSinceEvent(eventDate)
        let isFutureEvent = eventDate > Date()
        let dateFormatterString = isFutureEvent ? dateFormatter.string(from: eventDate) : shortDateFormatter.string(from: eventDate)
        
        if yearsSince > 0 {
            return ButtonContent (text: "It will be on a \(dayOfWeek(eventDate)) this year", imageView:  AnyView(EmptyView()))
        } else {
            return ButtonContent (text: "\(dateFormatterString) will be a \(dayOfWeek(eventDate))", imageView: AnyView(EmptyView()))
        }
    }
    
    
    private func detailsFourthLine(for item: Item, on eventDate: Date) -> ButtonContent {
        let daysUntil = daysUntilEvent(eventDate)
        let yearsSince = yearsSinceEvent(eventDate)
        
        if yearsSince > 0 {
            return ButtonContent (text: "Exact age is \(yearsSince) years old!", imageView:  AnyView(EmptyView()))
        } else {
            return ButtonContent (text: "\(daysUntil) days is exactly \(daysConvertedToYears(daysUntil)) years", imageView: AnyView(EmptyView()))
        }
    }
    
    
    
    
}

