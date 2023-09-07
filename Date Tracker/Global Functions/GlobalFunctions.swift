//
//  GlobalFunctions.swift
//  Date Tracker
//
//  Created by Cody McRoy on 9/3/23.
//

import Foundation


//-----------------------------------------------------------------------------

public func daysUntilEvent(_ eventDate: Date?) -> Int {
    guard let eventDate = eventDate else { return 0 }

    let calendar = Calendar.current

    // Normalize today and the event date to the start of the day
    let startOfToday = calendar.startOfDay(for: Date())
    let startOfEventDate = calendar.startOfDay(for: eventDate)

    var nextEventDate = startOfEventDate

    // Loop until nextEventDate is in the future or today
    while nextEventDate < startOfToday {
        if let newDate = calendar.date(byAdding: .year, value: 1, to: nextEventDate) {
            nextEventDate = calendar.startOfDay(for: newDate)
        } else {
            return 4206942069420  // Return this if we can't calculate the next event date
        }
    }

    // Check if today is the next event date
    if nextEventDate == startOfToday {
        return 0
    }

    let components = calendar.dateComponents([.day], from: startOfToday, to: nextEventDate)
    return components.day ?? 0
}


//-----------------------------------------------------------------------------

public func yearsSinceEvent(_ eventDate: Date?) -> Double {
    guard let eventDate = eventDate else { return 0.0 }
    
    // Only proceed if eventDate is in the past
    if eventDate >= Date() {
        return 0.0
    }
    
    let calendar = Calendar.current
    let components = calendar.dateComponents([.day], from: eventDate, to: Date())
    
    guard let days = components.day else { return 0.0 }
    
    let exactYears = Double(days) / 365.25
    
    let exactYearsTruncated = Double(floor(1000000 * exactYears)/1000000)  // this limits the double to 6 decimal places, adding another 0 to each increases by 1 place
    
    return exactYearsTruncated
    
}

//-----------------------------------------------------------------------------

public func daysConvertedToYears(_ days: Int) -> Double {
    // Calculate the exact years, accounting for leap years
    let exactYears = Double(days) / 365.25
    return exactYears
}

//-----------------------------------------------------------------------------

public func dayOfWeek(_ eventDate: Date?) -> String {
    guard let eventDate = eventDate else { return "Unknown" }
    
    let calendar = Calendar.current
    var nextEventDate = eventDate
    
    // Loop until nextEventDate is in the future, similar to daysUntilEvent function
    while nextEventDate < Date() {
        if let newDate = calendar.date(byAdding: .year, value: 1, to: nextEventDate) {
            nextEventDate = newDate
        } else {
            return "Unknown"  // Return "Unknown" if we can't calculate the next event date
        }
    }
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "EEEE"  // "EEEE" returns the full name of the weekday (e.g., "Sunday")
    return dateFormatter.string(from: nextEventDate)
}

//-----------------------------------------------------------------------------






//-----------------------------------------------------------------------------

public let dateTimeFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

//-----------------------------------------------------------------------------

public let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    formatter.timeStyle = .none
    return formatter
}()

//-----------------------------------------------------------------------------

public let shortDateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "MMMM dd"  // Month and day, without the year
    return formatter
}()
