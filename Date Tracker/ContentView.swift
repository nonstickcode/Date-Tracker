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
    
    @State private var isPresentingForm = false
    
    private var sortedItems: [Item] {
        return items.sorted { daysUntilEvent($0.eventDate) < daysUntilEvent($1.eventDate) } // This is what decides the order of the list after the one above does then lets daysUntilEvent sort it
    }
    
    
    @State private var isEditMode: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                headerView
                
                ScrollView {
                    LazyVStack {
                        ForEach(sortedItems, id: \.self) { item in
                            HStack {
                                NavigationLink(destination: itemDetailView(item: item)) {
                                    ItemButtonView(item: item)
                                }
                                
                                if isEditMode {
                                    Button("Delete") {
                                        deleteItem(item: item)
                                    }
                                    .background(Color.red)
                                    .foregroundColor(.white)
                                }
                            }
                        }
                        if items.isEmpty {
                            ItemButtonView(item: nil)
                        }
                    }
                    .padding(.bottom, 8)
                }
                .onChange(of: items.count) { newValue in
                    if newValue == 0 {
                        isEditMode = false
                    }
                }
                .background(Color.gray.opacity(0.7).edgesIgnoringSafeArea(.all))
                
                Text("Select an item")
                    .foregroundColor(.white)
            }
            .background(Color.blue.opacity(0.7).edgesIgnoringSafeArea(.all))
            .sheet(isPresented: $isPresentingForm) {
                NewDataEntryForm()
                    .environment(\.managedObjectContext, viewContext)
            }
        }
    }
    
    
    
    
    
    private var headerView: some View {
        HStack {
            Text("Date Tracker")
                .foregroundColor(.white)
                .font(.largeTitle)
                .bold()
                .padding()
            Spacer()
            HStack {
                Button(action: {
                    isPresentingForm.toggle()
                }) {
                    Image(systemName: "plus")
                        .foregroundColor(.white)
                }
                
                Button(isEditMode ? "Done" : "Edit") {
                    isEditMode.toggle()
                }
                .foregroundColor(.white)
            }
            .padding()
        }
    }
    
    
    
    
    private func deleteItem(item: Item) {
        withAnimation {
            viewContext.delete(item)
            do {
                try viewContext.save()
            } catch {
                // Handle the error appropriately instead of crashing
                print("Could not save context: \(error.localizedDescription)")
            }
        }
    }
    
    
    

    
    private func itemDetailView(item: Item) -> some View {
        VStack(spacing: 5) {
            Text("\(item.name!)'s \(item.eventType!) is \(item.eventDate!, formatter: dateFormatter)")
            
            Text("\(item.preferredPronoun!) \(item.eventType!) is in \(daysUntilEvent(item.eventDate)) days")
            
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





struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
    }
}
