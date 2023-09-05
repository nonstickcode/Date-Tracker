//
//  ItemButtonView.swift
//  Date Tracker
//
//  Created by Cody McRoy on 9/3/23.
//

import SwiftUI

import UserNotifications

struct ItemButtonView: View {
    var item: Item?
    
    var body: some View {
        RoundedRectangle(cornerRadius: 8)
            .fill(Color.white)
            .frame(height: 60)
            .overlay(
                VStack(spacing: 3) {
                    if let item = item, let eventDate = item.eventDate {
                        let name = item.name ?? "Unknown"
                        let eventType = item.eventType ?? "Unknown"
                        let daysUntil = daysUntilEvent(eventDate)
                        
                        
                        if eventDate > Date() {  // Check if the event is in the future
                            Text("\(name)'s \(eventType) is in \(daysUntil) days")
                                .mainButtonTextStyle()
                            Text("\(dayOfWeek(eventDate)) \(dateFormatter.string(from: eventDate))")
                                .mainButtonTextStyle()
                            
                        } else if daysUntil == 0 {
                            HStack {
                                Text("\(name)'s \(eventType) is Tomorrow!")
                                    .boldButtonTextStyle()
                                Image(systemName: "party.popper")
                                    .foregroundColor(.purple)
                            }
                            Text("\(dayOfWeek(eventDate)) \(shortDateFormatter.string(from: eventDate))")
                                .mainButtonTextStyle()
                            
                        } else if daysUntil == 365 {
                            HStack {
                                Text("\(name)'s \(eventType) is Today!")
                                    .boldButtonTextStyle()
                                Image(systemName: "party.popper.fill")
                                    .foregroundColor(.purple)
                            }
                            Text("\(dayOfWeek(eventDate)) \(shortDateFormatter.string(from: eventDate))")
                                .mainButtonTextStyle()
                            
                                .onAppear {
                                    self.scheduleNotification(for: item)
                                }
                        } else {
                            Text("\(name)'s \(eventType) is in \(daysUntil) days")
                                .mainButtonTextStyle()
                            Text("\(dayOfWeek(eventDate)) \(shortDateFormatter.string(from: eventDate))")
                                .mainButtonTextStyle()
                        }
                        
                        
                    } else {
                        Text("No data available.")
                            .emptyButtonTextStyle()
                        HStack {
                            
                            Text("Tap ")
                                .emptyButtonTextStyle()
                            Image(systemName: "plus.app")
                                .bold()
                                .padding(-6)
                            Text(" to add new event.")
                                .emptyButtonTextStyle()
                        }
                    }
                }
            )
            .padding(.top, 8)
            .padding([.leading, .trailing], 16)
    }
    
    // Added for notifications on day of event ---------------------------------------
    
    func scheduleNotification(for item: Item) {
        let content = UNMutableNotificationContent()
        content.title = "\(item.name ?? "An event") is today!"
        content.body = "Don't forget about \(item.eventType ?? "the event")."
        content.sound = UNNotificationSound.default
        
        // Schedule the notification for "now"
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        
        let request = UNNotificationRequest(identifier: item.id ?? "defaultID", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error)")
            }
        }
    }
    
    
    // END of notifications on day of event ---------------------------------------
    
}
