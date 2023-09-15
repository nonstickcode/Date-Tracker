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
    
    
    @State private var noDataPresentInRecycleBin: Bool = false
    
    
    var body: some View {
        NavigationView {
            
            ZStack {
                
                VStack {
                    headerView
                    ScrollView(.vertical, showsIndicators: false) {
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
                                            restoreItem(item: item, with: self.viewContext)
                                        }) {
                                            Label("Restore Event", systemImage: "arrowshape.turn.up.backward.badge.clock")
                                        }
                                        
                                    // long press menu ends here ----------------------------------------------
                                        
                                    }
                                    if isEditMode {
                                        Button(action: {
                                            restoreItem(item: item, with: self.viewContext)
                                        }) {
                                            Image(systemName: "arrowshape.turn.up.backward.badge.clock")
                                                .font(.system(size: 36))
                                                .shadow(color: .black.opacity(0.5), radius: 2, x: 2, y: 2)
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
                    .task {
                        if items.count == 0 {
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
            HStack {
                NavigationLink(destination: ContentView().environment(\.managedObjectContext, viewContext)) {
                    Image(systemName: "chevron.backward")
                        .foregroundColor(Color.mainHeaderTextColor)
                        .font(.system(size: 24))
                }
                Spacer()
            }
            .padding(.leading, 12)
            .frame(width: 80)  // Explicitly set frame width to match first header
            
            Spacer(minLength: 0)
            // Center - Text
            Text("Recycle Bin")
                .mainHeaderStyle()
            
            Spacer(minLength: 0)

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
            .font(.custom("Quicksand-Bold", size: 12))
            .foregroundColor(Color.mainHeaderTextColor)
            .frame(width: 80) // Explicitly set frame width to match first header
        }
        .frame(height: 60)
        .padding([.leading, .trailing], 8)
    }

    
}

struct RecycleBinView_Previews: PreviewProvider {
    static var previews: some View {
        RecycleBinView().environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
    }
}
