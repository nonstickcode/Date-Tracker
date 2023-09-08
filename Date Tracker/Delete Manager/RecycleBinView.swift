//
//  RecycleBinView.swift
//  Date Tracker
//
//  Created by Cody McRoy on 9/7/23.
//

import SwiftUI
import CoreData

struct RecycleBinView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var showingDeleteAlert = false
    @State private var itemToDelete: Item?
    
    @FetchRequest(
        entity: Item.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.dateEventTaggedForDelete, ascending: true)], // Sorting by dateEventTaggedForDelete
        predicate: NSPredicate(format: "taggedForDelete == %@", NSNumber(value: true)),  // Filtering by taggedForDelete
        animation: .default)
    private var items: FetchedResults<Item>

    // Sort function below ----------------------------------------------------------------
    
    private var sortedItems: [Item] {
        return items.sorted { item1, item2 in
            let daysUntil1 = daysUntilEvent(item1.eventDate)
            let daysUntil2 = daysUntilEvent(item2.eventDate)
            
            if daysUntil1 == 365 && daysUntil2 != 365 {
                return true
            }
            
            if daysUntil1 != 365 && daysUntil2 == 365 {
                return false
            }
            
            if daysUntil1 == 0 && daysUntil2 != 0 && daysUntil2 != 365 {
                return true
            }
            
            if daysUntil1 != 0 && daysUntil2 == 0 && daysUntil1 != 365 {
                return false
            }
            
            return daysUntil1 < daysUntil2
        }
    }
    
    // Sort function above ----------------------------------------------------------------
    
    @State private var isPresentingForm = false
    @State private var selectedItem: Item?
    @State private var isEditMode: Bool = false
    
    
    @State private var showOverlay: Bool = false
    
    
    @State private var noDataPresent: Bool = false // State variable
    
    
    var body: some View {
        
        ZStack {
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
                                        self.showOverlay = true
                                    }) {
                                        RecycleBinItemButtonView(item: item)
                                    }
                                    // long press menu starts here ----------------------------------------------
//                                    .contextMenu {
//                                        
//                                        Button(action: {
//                                            // add edit action here
//                                        }) {
//                                            Label("Share", systemImage: "square.and.arrow.up")
//                                        }
//                                        Button(action: {
//                                            // add edit action here
//                                        }) {
//                                            Label("Edit", systemImage: "pencil")
//                                        }
//                                        Button(action: {
//                                            // add edit action here
//                                        }) {
//                                            Label("Settings", systemImage: "gear")
//                                        }
//                                        Button(action: {
//                                            // add edit action here
//                                        }) {
//                                            Label("Coming Soon", systemImage: "questionmark.folder")
//                                        }
//                                        Button(action: {
//                                            // add edit action here
//                                        }) {
//                                            Label("Coming Soon", systemImage: "questionmark.folder")
//                                        }
//                                        Button(action: {
//                                            // add edit action here
//                                        }) {
//                                            Label("Coming Soon", systemImage: "questionmark.folder")
//                                        }
//                                        Button(action: {
//                                            deleteItem(item: item)
//                                        }) {
//                                            Label("Delete", systemImage: "trash")
//                                                .foregroundColor(.red)
//                                        }
                                        // long press menu ends here ----------------------------------------------
                                        
                                        
                                        
                                        
                                        
                                    }
                                    
                                    
                                    
                                    
                                    
                                    
//                                    if isEditMode {
//                                        Button(action: {
//                                            deleteItem(item: item)
//                                        }) {
//                                            Image(systemName: "delete.backward")
//                                                .font(.system(size: 24))
//                                        }
//                                        .foregroundColor(.mainHeaderTextColor)
//                                        .padding(.trailing, 20)
//                                    }
                                    
                                    
                                    
                                    
                                    
                                    
                                }
                            }
                            if items.isEmpty {
                                ItemButtonView(item: nil, noDataPresent: $noDataPresent)
                            }
                        }
                        .padding(.bottom, 8)
                    }
                    .onChange(of: items.count) { newValue in
                        if newValue == 0 {
                            isEditMode = false
                            noDataPresent = true
                        } else {
                            noDataPresent = false
                        }
                    }
                    .mainGradientBackground()
                    
                    Text("Select an event")
                        .mainFooterTextStyle()
                        .padding(.top, 12)
                        .frame(height: 25)
                }
                .background(Color.mainHeaderBackground.edgesIgnoringSafeArea(.all))
                
                if showOverlay, let selectedItem = selectedItem {
                    HalfModalView {
                        ItemDetailView(item: selectedItem)
                    }
                    
                    .transition(.move(edge: .bottom))
                    .onTapGesture {
                        withAnimation {
                            showOverlay = false
                        }
                    }
                }
                
            }
            .deletionAlert(showingAlert: $showingDeleteAlert, itemToDelete: $itemToDelete, deleteConfirmed: softDeleteConfirmed, context: viewContext)
            .onAppear {
                showOverlay = false
            }
        }
    }
    
    
    
    
    
    
    
    private var headerView: some View {
        HStack {
            Text("Recycle Bin")
                .mainHeaderStyle()
                .padding()
            Spacer()
//            HStack {
//                Button(action: {
//                    isEditMode = false // Disable edit mode when the '+' button is pressed.
//                    isPresentingForm = true
//                }) {
//                    Image(systemName: "plus.app")
//                        .foregroundColor(Color.mainHeaderTextColor)
//                        .font(.system(size: 24))
//                        .padding(5)
//                        .scaleEffect(noDataPresent ? 1.4 : 1.0)
//                            .animation(noDataPresent ? Animation.easeInOut(duration: 1.0).repeatForever(autoreverses: true) : .default, value: noDataPresent)
//                }
//                .foregroundColor(Color.mainHeaderTextColor)
//                .sheet(isPresented: $isPresentingForm) {
//                    NewDataEntryForm()
//                        .environment(\.managedObjectContext, viewContext)
//                }
//                Button(isEditMode ? "Done" : "Edit") {
//                    isEditMode.toggle()
//                }
//                .font(.custom("Quicksand-Bold", size: 16))
//                .foregroundColor(Color.mainHeaderTextColor)
//                .frame(minWidth: 50, maxWidth: 50, minHeight: 40, maxHeight: 40)  // Explicitly set frame
//            }
//            .padding()
        }
        .frame(height: 60)
    }
    
    
    
//    private func deleteItem(item: Item) {
//        prepareForDeletion(item: item, with: viewContext, showingAlert: &showingDeleteAlert, itemToDelete: &itemToDelete)
//
//    }

    


struct RecycleBinView_Previews: PreviewProvider {
    static var previews: some View {
        RecycleBinView().environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
    }
}
