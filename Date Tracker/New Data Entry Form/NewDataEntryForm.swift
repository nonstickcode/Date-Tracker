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
    
//    @State private var moveDown1 = false  // For text animation
//    @State private var moveDown2 = false  // For chevron icon animation
    
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
    
    @State private var eventNotifications = true
    
    
    
    
    var body: some View {
        
        
        VStack {
            
            //
            Text("Add New Event")
                .formHeaderStyle()
                .padding(.bottom, 4)
                .padding(.top, 8)
            
//            Text("Swipe down to dismiss")
//                .font(.caption)
//                .foregroundColor(.secondary)
//                .padding(.top, 4)
//                .gesture(
//                    DragGesture()
//                        .onChanged { value in
//                            // Detect swipe down gesture
//                            if value.translation.height > 100 {
//                                presentationMode.wrappedValue.dismiss()
//                            }
//                        }
//                )
     
            
//            Image(systemName: "chevron.compact.down") // add .scaleEffect(.bounce) when ios 17 drops
//                .padding(4)
//                .font(.system(size: 30))
//                .shadow(color: .gray.opacity(0.8), radius: 2, x: 2, y: 2)
//                .offset(y: moveDown2 ? 5 : -5)
//                .onAppear {
//                    startMoving2()
//                }
            
            Form {
                Section(header: Text("Name of Person or Event").formRegularStyle()) {
                    TextField("enter name here", text: $newEventName)
                        .formPlaceholderTextStyle()
                        .task {
                                    self.newEventName = String(self.newEventName.prefix(40))
                                }

                }
                
//                Section(header: Text("Notifications for this event").formRegularStyle()) {
//                    Toggle("Notifications", isOn: $eventNotifications)
//                        
//                }
                
                //                Section(header: Text("Preferred pronoun for person or event").formRegularStyle()) {
                //                    TextField("enter pronoun here", text: $newPreferredPronoun)
                //                        .font(.custom("RobotoMono-Italic", size: 14))
                //                }
                
                Section(header: Text("Event Date, upcoming or past").formRegularStyle()) {
                    DatePicker("Select date", selection: $newEventDate, displayedComponents: [.date])
                        .datePickerStyle(GraphicalDatePickerStyle())
//                        .onChange(of: newEventDate) { oldValue, newValue in
//                            let calendar = Calendar.current
//                            selectedDay = calendar.component(.day, from: newValue)
//                            selectedMonth = months[calendar.component(.month, from: newValue) - 1]
//                            selectedYear = calendar.component(.year, from: newValue)
//                        }

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
                                    .shadow(color: .gray.opacity(0.8), radius: 2, x: 2, y: 2)
                                
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
        newItem.eventDate = newEventDate
        newItem.eventType = newEventType
        
        newItem.taggedForDelete = false
        newItem.timeUntilHardDelete = 1000000
        
        
        
        do {
            try viewContext.save()
            self.presentationMode.wrappedValue.dismiss()
        } catch {
            print("Error saving: \(error)")
            // Handle the error appropriately
        }
    }
    
    
    
    
//    private func startMoving1() {
//        withAnimation(Animation.linear(duration: 2.0).repeatForever(autoreverses: false)) {  // For text animation
//            moveDown1.toggle()
//        }
//    }
//    private func startMoving2() {
//        withAnimation(Animation.linear(duration: 2.0).repeatForever(autoreverses: false)) {  // For chevron icon animation
//            moveDown2.toggle()
//        }
//    }
    
    
    
    
    
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

