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
    
    @State private var isPresentingForm = false
    @State private var selectedItem: Item?  // <-- This is your state variable for the selected item
    @State private var isEditMode: Bool = false
    
    
    
    var body: some View {
        NavigationView {
            VStack {
                headerView
                
                ScrollView {
                    LazyVStack {
                        Spacer()
                        ForEach(sortedItems, id: \.self) { item in
                            HStack {
                                Button(action: {
                                    self.selectedItem = item
                                }) {
                                    ItemButtonView(item: item)
                                }
                                
                                
                                // long press menu starts here ----------------------------------------------
                                .contextMenu {
                                    Button(action: {
                                        deleteItem(item: item)
                                    }) {
                                        Label("Delete", systemImage: "trash")
                                    }
                                    Button(action: {
                                        // add edit action here
                                    }) {
                                        Label("Edit", systemImage: "pencil")
                                    }
                                    // long press menu ends here ----------------------------------------------
                                    
                                }
                                if isEditMode {
                                    Button(action: {
                                        deleteItem(item: item)
                                    }) {
                                        Image(systemName: "delete.backward")
                                            .font(.system(size: 24))
                                    }
                                    
                                    .foregroundColor(.white)
                                    .padding(.trailing, 20)
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
                .background(Color.gray.opacity(0.9).edgesIgnoringSafeArea(.all))
                
                Text("Select an event")
                    .foregroundColor(.white)
                    .padding(.top, 12)
                    .frame(height: 25)
            }
            .background(Color.accentColor.edgesIgnoringSafeArea(.all))
            .sheet(isPresented: $isPresentingForm) {
                NewDataEntryForm()
                    .environment(\.managedObjectContext, viewContext)
            }
            
        }
        .sheet(item: $selectedItem) { item in
                    HalfModalView {
                        ItemDetailView(item: item)
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
                    isEditMode = false // Disable edit mode when the '+' button is pressed.
                    isPresentingForm.toggle()
                }) {
                    Image(systemName: "plus.app")
                        .foregroundColor(.white)
                        .font(.system(size: 24))
                        .padding(10)
                }
                
                Button(isEditMode ? "Done" : "Edit") {
                    isEditMode.toggle()
                }
                .foregroundColor(.white)
            }
            .padding()
        }
        .frame(height: 60)
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
    
}
    
    
    
  





struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
    }
}
