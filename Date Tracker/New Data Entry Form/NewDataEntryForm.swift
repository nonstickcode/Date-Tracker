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
    
    @State private var moveDown = false
    
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
        
        
        VStack {
            
            //
            Text("Add New Event")
                .formHeaderStyle()
                .padding(.bottom, 4)
                .padding(.top, 8)
            
            Text("Swipe down to dismiss")
                .font(.caption)
                .foregroundColor(.secondary)
                .padding(.top, 4)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            // Detect swipe down gesture
                            if value.translation.height > 100 {
                                presentationMode.wrappedValue.dismiss()
                            }
                        }
                )
            Image(systemName: "chevron.compact.down")
            // add .scaleEffect(.bounce) when ios 17 drops
                .padding(4)
                .font(.system(size: 30))
                                .offset(y: moveDown ? 10 : 0)
                                .onAppear {
                                    startMoving()
                                }
            
            Form {
                Section(header: Text("Name of Person or Event").formRegularStyle()) {
                    TextField("enter name here", text: $newEventName)
                        .font(.custom("RobotoMono-Italic", size: 14))
                }
                
                Section(header: Text("Preferred pronoun for person or event").formRegularStyle()) {
                    TextField("enter pronoun here", text: $newPreferredPronoun)
                        .font(.custom("RobotoMono-Italic", size: 14))
                }
                
                Section(header: Text("Event Date, upcoming or past").formRegularStyle()) {
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
                
                
                
                
                Section(header: Text("Event Type").formRegularStyle()) {
                    Picker("Select Event Type", selection: $newEventType) {
                        ForEach(newEventTypeOptions, id: \.self) {
                            Text($0)
                        }
                    }
                }
                
                // Save Button --------------------------------------------------------------------
                
                Section {
                    VStack {
                        
                        Button(action: addItem) {
                            HStack {
                                Spacer()
                                Image(systemName: "calendar.badge.plus")
                                    .font(.system(size: 30))
                                    .padding(.trailing, 10)
                                Text("Save")
                                    .formSaveButtonStyle()
                                Spacer()
                            }
                            .padding(10)
                            
                            .frame(minWidth: 0, maxWidth: .infinity)
                        }
                        .background(Color.formHeaderAndSaveButtonBackground)
                        .foregroundColor(.formHeaderAndSaveButtonForeground)
                        .cornerRadius(10)
                        
                    }
                    
                }
                .frame(minHeight: 0, maxHeight: .infinity)
                
                // Save Button End ------------------------------------------------------------------
                
            }
            
            
            
            
            
            
            // Alert ---------------------------------------------------------------------------
            
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Error"),
                      message: Text("Name field is required."),
                      dismissButton: .default(Text("OK")))
            }
            
            // Alert End -----------------------------------------------------------------------
        }
        .background(Color.formHeaderAndSaveButtonBackground)
        
    }
    
    
    
    
    
    
    private func addItem() {
        guard !newEventName.isEmpty else {
            showAlert = true
            return
        }
        
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
            self.presentationMode.wrappedValue.dismiss()
        } catch {
            print("Error saving: \(error)")
            // Handle the error appropriately
        }
    }
    
    
    
    
    private func startMoving() {
        withAnimation(Animation.linear(duration: 2.0).repeatForever(autoreverses: false)) {
                moveDown.toggle()
            }
        }
    
    
    
    
    
}



struct NewDataEntryForm_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            ContentView()  // Your main content view
                .background(Color.gray.opacity(0.2))
            
            NewDataEntryForm()  // Your form
                .background(Color.white)
                .cornerRadius(20)
                .offset(y: 10)  // Change this value to adjust the vertical position
        }
        .previewLayout(.sizeThatFits)
    }
}

