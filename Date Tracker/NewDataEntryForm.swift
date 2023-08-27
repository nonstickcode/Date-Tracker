//
//  NewDataEntryForm.swift
//  Date Tracker
//
//  Created by Cody McRoy on 8/26/23.
//

import SwiftUI
import CoreData




struct NewDataEntryForm: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    
    let newEventTypeOptions = ["Birthday", "Anniversary", "Holiday"]
    
    let stringOptions2 = ["Choice A", "Choice B", "Choice C"] //---------------
    
    @State private var newEventName: String = ""
    @State private var newPreferredPronoun: String = ""
    @State private var newEventDate = Date()
    @State private var newEventType: String = ""
    
    @State private var selectedString2: String = "Choice A" //------------------
    
    
    
    
    
    
    var body: some View {
        
        NavigationView {
            
            Form {
                
                
                Section(header: Text("Name of Person or Event")) {
                    
                    TextField("enter text here", text: $newEventName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                
                Section(header: Text("Preferred pronoun for person or event")) {
                    
                    TextField("enter text here", text: $newPreferredPronoun)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                
                Section(header: Text("New Date Entry")) {
                    
                    DatePicker("Select Date", selection: $newEventDate, displayedComponents: [.date])
                }
                
                Section(header: Text("New Date Entry")) {
                    
                    Picker("Select Custom String 1", selection: $newEventType) {
                        ForEach(newEventTypeOptions, id: \.self) {
                            Text($0)
                        }
                    }
                }
                
                Section(header: Text("New Date Entry")) {
                    
                    Picker("Select Custom String 2", selection: $selectedString2) {
                        ForEach(stringOptions2, id: \.self) {
                            Text($0)
                        }
                    }
                }
                
                
                Button(action: addItem) {
                    Label("Save Event", systemImage: "circle")
                }
                
                
            }
            .navigationBarTitle("New Entry", displayMode: .inline)
        }
        
    }
    
    
    
    
    
    private func addItem() {
        
        let newItem = Item(context: viewContext)
        let uuid = UUID().uuidString
        
        newItem.timestamp = Date()
        newItem.id = uuid
        newItem.name = newEventName
        newItem.preferredPronoun = newPreferredPronoun
        newItem.eventDate = newEventDate
        newItem.eventType = newEventType
        
        
        
        do {
            try viewContext.save()
            self.presentationMode.wrappedValue.dismiss()  // Add this line to dismiss the view
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}



struct NewDataEntryForm_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            NewDataEntryForm()
        }
    }
}
