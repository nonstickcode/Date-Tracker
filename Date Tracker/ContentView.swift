//
//  ContentView.swift
//  Date Tracker
//
//  Created by Cody McRoy on 8/26/23.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: false)],  // This is what decides the order of the list when fetched
        animation: .default)
    
    private var items: FetchedResults<Item>
    
    private var sortedItems: [Item] {
        return items.sorted { daysUntilEvent($0.eventDate) < daysUntilEvent($1.eventDate) } // This is what decides the order of the list after the one above does then lets daysUntilEvent sort it
    }
    
    var body: some View {
        
        NavigationView {
            
            VStack {
                HStack {
                    Text("Date Tracker")
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .bold()
                        .padding()
                    Spacer()
                }
                List {
                    ForEach(sortedItems, id: \.self) { item in
                        NavigationLink {
                            VStack(spacing: 5) {
                                Text("\(item.name!)'s \(item.eventType!) is \(item.eventDate!, formatter: dateFormatter)")
                                
                                Text("\(item.preferredPronoun!) \(item.eventType!) is in \(daysUntilEvent(item.eventDate)) days")
                                
                                if yearsSinceEvent(item.eventDate) > 0 {
                                    Text("on \(dayOfWeek(item.eventDate)) \(item.eventDate!, formatter: shortDateFormatter)")
                                } else {
                                    Text("\(item.eventDate!, formatter: dateFormatter) will be a \(dayOfWeek(item.eventDate))")
                                }
                                
                                if yearsSinceEvent(item.eventDate) > 0 {
                                    Text("\(item.name!) is exactly \(yearsSinceEvent(item.eventDate)) years old!")
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
                        } label: {
                            VStack(alignment: .leading, spacing: 3) {
                                Text("\(item.name!)'s \(item.eventType!) is in \(daysUntilEvent(item.eventDate)) days")  // This is what is shown in Label for each item
                                
                                Text("\(dayOfWeek(item.eventDate)) \(item.eventDate!, formatter: shortDateFormatter)")
                            }
                        }
                    }
                    .onDelete(perform: deleteItems)
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        HStack {
                            NavigationLink(destination: NewDataEntryForm()) {
                                Image(systemName: "plus")
                                    .foregroundColor(.white)
                            }
                            EditButton()
                                .foregroundColor(.white)
                        }
                    }
                }
                Text("Select an item")
                    .foregroundColor(.white)
            }
            .background(Color.blue.edgesIgnoringSafeArea(.all))
        }
    }
    
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            let itemsToDelete = offsets.map { sortedItems[$0] }
            
            for itemToDelete in itemsToDelete {
                if let index = items.firstIndex(where: { $0.id == itemToDelete.id }) {
                    viewContext.delete(items[index])
                }
            }
            
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}


private func daysUntilEvent(_ eventDate: Date?) -> Int {
    guard let eventDate = eventDate else { return 0 }
    
    let calendar = Calendar.current
    var nextEventDate = eventDate
    
    // Loop until nextEventDate is in the future
    while nextEventDate < Date() {
        if let newDate = calendar.date(byAdding: .year, value: 1, to: nextEventDate) {
            nextEventDate = newDate
        } else {
            return 0  // Return 0 if we can't calculate the next event date
        }
    }
    
    let components = calendar.dateComponents([.day], from: Date(), to: nextEventDate)
    return components.day ?? 0
}


private func yearsSinceEvent(_ eventDate: Date?) -> Double {
    guard let eventDate = eventDate else { return 0.0 }
    
    // Only proceed if eventDate is in the past
    if eventDate >= Date() {
        return 0.0
    }
    
    let calendar = Calendar.current
    let components = calendar.dateComponents([.day], from: eventDate, to: Date())
    
    guard let days = components.day else { return 0.0 }
    
    let exactYears = Double(days) / 365.25
    
    return exactYears
    
}

private func daysConvertedToYears(_ days: Int) -> Double {
    // Calculate the exact years, accounting for leap years
    let exactYears = Double(days) / 365.25
    return exactYears
}

private func dayOfWeek(_ eventDate: Date?) -> String {
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


private let dateTimeFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    formatter.timeStyle = .none
    return formatter
}()

private let shortDateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "MMMM dd"  // Month and day, without the year
    return formatter
}()


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
    }
}
