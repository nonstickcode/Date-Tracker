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
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: false)],  // This is what decides the order or the list
        animation: .default)
    private var items: FetchedResults<Item>
    
    var body: some View {
        
        NavigationView {
            
            List {
                ForEach(items) { item in
                    NavigationLink {
                        Text("\(item.name!)")
                        Text("\(item.preferredPronoun!)")
                        Text("\(item.eventDate!)")
                        Text("Item created: \(item.timestamp!, formatter: itemFormatter)")
                        
                        Text("\(item.id!)")
                            .foregroundColor(.blue)
                    } label: {
                        
                        Text(item.timestamp!, formatter: itemFormatter)  // This is what is shown in Label for each item
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    HStack {
                        NavigationLink(destination: NewDataEntryForm()) {
                            Label("New Event", systemImage: "plus")
                        }
//                        Button(action: addItem) {
//                            Label("Add Item", systemImage: "plus")
//                        }
                    }
                    
                }
            }
            Text("Select an item")
        }
    }
    
    private func addItem() {
        withAnimation {
            
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()
            
            let uuid = UUID().uuidString
            newItem.id = uuid
            
            
            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)
            
            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
