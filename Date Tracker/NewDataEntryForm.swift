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
    
    @State private var showAlert = false
    
    @State private var newEventName: String = ""
    @State private var newPreferredPronoun: String = ""
    @State private var newEventDate = Date()
    @State private var newEventType: String = "Birthday"
    
    let newEventTypeOptions = ["Birthday", "Anniversary", "Holiday", "Vacation"]
    
    
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Name of Person or Event")) {
                    TextField("enter name here", text: $newEventName)
                }
                Section(header: Text("Preferred pronoun for person or event")) {
                    TextField("enter pronoun here", text: $newPreferredPronoun)
                }
                Section(header: Text("Event Date, upcoming or past")) {
                    DatePicker("Select Date", selection: $newEventDate, displayedComponents: [.date])
                }
                Section(header: Text("Event Type")) {
                    Picker("Select Event Type", selection: $newEventType) {
                        ForEach(newEventTypeOptions, id: \.self) {
                            Text($0)
                        }
                    }
                }
                
                // Save Button --------------------------------------------------------------------
                
                Section {
                    VStack {
                        Spacer()
                        Button(action: addItem) {
                            Text("Save Event")
                                .font(.system(size: 18))
                                .bold()
                                .frame(minWidth: 0, maxWidth: .infinity)
                                .padding()
                        }
                        .background(Color.accentColor)
                        .foregroundColor(Color.white)
                        .cornerRadius(10)
                        Spacer()
                    }
                }
                .frame(minHeight: 0, maxHeight: .infinity)
                
                // Save Button End ------------------------------------------------------------------
                
            }
            .navigationBarTitle("New Event Entry", displayMode: .inline)
            
            // Alert ---------------------------------------------------------------------------
            
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Error"),
                      message: Text("All fields are required."),
                      dismissButton: .default(Text("OK")))
            }
            
            // Alert End -----------------------------------------------------------------------
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
        
        if newEventName.isEmpty || newPreferredPronoun.isEmpty {
            showAlert = true
            return
        }
        
        do {
            try viewContext.save()
            self.presentationMode.wrappedValue.dismiss()  // line to dismiss the view after save
        } catch {
            print("Error saving: \(error)")
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
