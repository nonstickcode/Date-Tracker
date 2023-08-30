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
    
    @State private var selectedMonth = "January"
    @State private var selectedDay = 1
    @State private var selectedYear = 2023
    
    let months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    
    let newEventTypeOptions = ["Birthday", "Anniversary", "Holiday", "Vacation"]
    
    var customDate: Date {
        var components = DateComponents()
        components.day = selectedDay
        components.month = months.firstIndex(of: selectedMonth)! + 1
        components.year = selectedYear
        return Calendar.current.date(from: components) ?? Date()
    }
    
    
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
                    VStack {
                        Picker("Month", selection: $selectedMonth) {
                            ForEach(months, id: \.self) { month in
                                Text(month).tag(month)
                            }
                        }
                        
                        
                        Picker("Day", selection: $selectedDay) {
                            ForEach(1..<32) { day in
                                Text("\(day)").tag(day)
                            }
                        }
                        
                        
                        Picker("Year", selection: $selectedYear) {
                            ForEach(1920..<2100) { year in
                                Text(String(format: "%ld", locale: Locale(identifier: "en_US_POSIX"), year)).tag(year)

                            }
                        }
                        
                        
                    }
                    .onAppear {
                        // Initialize the custom picker with the existing date
                        let components = Calendar.current.dateComponents([.day, .month, .year], from: newEventDate)
                        selectedMonth = months[(components.month ?? 1) - 1]
                        selectedDay = components.day ?? 1
                        selectedYear = components.year ?? 2023
                    }
                    .onChange(of: customDate) { newDate in
                        newEventDate = newDate
                    }
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
