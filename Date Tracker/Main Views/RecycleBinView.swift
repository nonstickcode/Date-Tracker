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
        return items.sorted { (item1, item2) in
            guard let date1 = item1.dateEventTaggedForDelete, let date2 = item2.dateEventTaggedForDelete else {
                return false
            }
            return date1 < date2
        }
    }
    
    // Sort function above ----------------------------------------------------------------
    
    @State private var isPresentingForm = false
    @State private var selectedItem: Item?
    @State private var isEditMode: Bool = false
    
    
    @State private var showOverlay: Bool = false
    
    
    @State private var noDataPresentInRecycleBin: Bool = false // State variable
    
    
    var body: some View {
        NavigationView {
            
            ZStack {
                
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
                                        RecycleBinItemButtonView(item: item, noDataPresentInRecycleBin: $noDataPresentInRecycleBin)
                                        
                                        
                                        
                                    }
                                    // long press menu starts here ----------------------------------------------
                                    .contextMenu {
                                        
                                        Button(action: {
                                            // add edit action here
                                        }) {
                                            Label("Share", systemImage: "square.and.arrow.up")
                                        }
                                        Button(action: {
                                            restoreItem(item: item, with: self.viewContext)  // added restoreItem here
                                        }) {
                                            Label("Edit", systemImage: "pencil")
                                        }
                                        
                                        // long press menu ends here ----------------------------------------------
                                        
                                    }
                                    if isEditMode {
                                        Button(action: {
                                            restoreItem(item: item, with: self.viewContext)
                                        }) {
                                            Image(systemName: "arrowshape.turn.up.backward.badge.clock")
                                                .font(.system(size: 24))
                                        }
                                        .foregroundColor(.mainHeaderTextColor)
                                        .padding(.trailing, 20)
                                    }
                                    
                                }
                            }
                            if items.isEmpty {
                                RecycleBinItemButtonView(item: nil, noDataPresentInRecycleBin: $noDataPresentInRecycleBin)
                            }
                        }
                        .padding(.bottom, 8)
                    }
                    .onChange(of: items.count) { newValue in
                        if newValue == 0 {
                            isEditMode = false
                            
                        }
                    }
                    
                    .mainGradientBackground()
                    
                    Text("Select an event to restore")
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
            
        }
        .navigationBarBackButtonHidden(true)
        .navigationViewStyle(StackNavigationViewStyle())
        .onAppear {
            cleanUpItems(with: self.viewContext)
        }
    }
    
    
    
    
    
    
    
    
    private var headerView: some View {
        HStack {
            // Left - Navigation Link
            NavigationLink(destination: ContentView().environment(\.managedObjectContext, viewContext)) {
                Image(systemName: "chevron.backward")
                    .foregroundColor(Color.mainHeaderTextColor)
                    .font(.system(size: 24))
            }
            .frame(width: 50) // Explicitly set frame width to match first header
            
            Spacer(minLength: 0) // Auto Spacer for the middle content
            
            // Center - Text
            Text("Recycle Bin")
                .mainHeaderStyle()
            
            Spacer(minLength: 0) // Auto Spacer for the remaining content

            // Right - Button
            Button(action: {
                isEditMode.toggle()
            }) {
                if isEditMode {
                    Text("Done")
                } else {
                    VStack {
                        Text("Restore")
                        Text("Event")
                    }
                }
            }
            .font(.custom("Quicksand-Bold", size: 14))
            .foregroundColor(Color.mainHeaderTextColor)
            .frame(width: 50) // Explicitly set frame width to match first header
        }
        .frame(height: 60)
        .padding(.horizontal, 5) 
    }

    
}

struct RecycleBinView_Previews: PreviewProvider {
    static var previews: some View {
        RecycleBinView().environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
    }
}
