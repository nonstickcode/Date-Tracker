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
    
    @State private var showingRecycleBin = false
    @State private var showingDeleteAlert = false
    @State private var itemToDelete: Item?
    @State private var isPresentingForm = false
    @State private var selectedItem: Item?
    @State private var isEditMode: Bool = false
    @State private var showOverlay: Bool = false
    @State private var noDataPresent: Bool = false
    @State private var noDataPresentInRecycleBin = false
    
    @State private var scrollOffset: CGFloat = 0.0
    @State private var lastScrollOffset: CGFloat = 0.0
    
    
    @FetchRequest(
        entity: Item.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: false)],
        predicate: NSPredicate(format: "taggedForDelete == %@", NSNumber(value: false)),
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
    
    @State private var showSplashScreenView = false
    
    var body: some View {
        
        
        let footerScale = max(min(1.0 + scrollOffset / 100, 1.0), 0.0)  // Adjust scale
        let footerOpacity = max(min(1.0 + scrollOffset / 100, 1.0), 0.0)  // Adjust opacity
        
        
        
        NavigationView {
         
                ZStack {
                    VStack {
                        headerView
                        ScrollView(.vertical, showsIndicators: false) {
                            
                            
                            
                            GeometryReader { geometry in
                                Color.clear
                                    .preference(key: ScrollOffsetKey.self, value: geometry.frame(in: .global).minY)
                            }
                            
                            
                            
                            LazyVStack {
                                Spacer()
                                ForEach(sortedItems, id: \.self) { item in
                                    HStack {
                                        Button(action: {
                                            self.selectedItem = item
                                            self.showOverlay = true
                                        }) {
                                            ItemButtonView(item: item, noDataPresent: $noDataPresent)
                                        }
                                        // long press menu starts here ----------------------------------------------
                                        .contextMenu {
                                            
//                                            Button(action: {
//                                                // add share action here
//                                            }) {
//                                                Label("Share", systemImage: "square.and.arrow.up")
//                                            }
//                                            Button(action: {
//                                                // add edit action here
//                                            }) {
//                                                Label("Edit", systemImage: "pencil")
//                                            }
//                                            Button(action: {
//                                                // add setting action here
//                                            }) {
//                                                Label("Settings", systemImage: "gear")
//                                            }
                                            Button(action: {
                                                // add some action here
                                            }) {
                                                Label("Coming Soon", systemImage: "questionmark.folder")
                                            }
                                            Button(action: {
                                                // add some action here
                                            }) {
                                                Label("Coming Soon", systemImage: "questionmark.folder")
                                            }
                                            Button(action: {
                                                deleteItem(item: item)
                                            }) {
                                                Label("Delete", systemImage: "trash")
                                                    .foregroundColor(.red)
                                            }
                                            // long press menu ends here ----------------------------------------------
                                            
                                        }
                                        if isEditMode {
                                            Button(action: {
                                                deleteItem(item: item)
                                            }) {
                                                Image(systemName: "delete.backward")
                                                    .font(.system(size: 36))
                                                    .shadow(color: .black.opacity(0.5), radius: 2, x: 2, y: 2)
                                            }
                                            .foregroundColor(.mainHeaderTextColor)
                                            .padding(.trailing, 20)
                                        }
                                    }
                                }
                                if items.isEmpty {
                                    ItemButtonView(item: nil, noDataPresent: $noDataPresent)
                                }
                            }
                            .padding(.bottom, 12)
                            .padding(.top, -20)  // not sure what this is fighting but it got large gap when shrinking header feature added
                        }
                        .task {
                            if items.count == 0 {
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
                            .frame(height: 25 * footerScale)  // Scale the footer
                            .opacity(Double(footerOpacity))  // Adjust the opacity of the footer text
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
                
                
                .onPreferenceChange(ScrollOffsetKey.self) { offset in
                    if abs(lastScrollOffset - offset) > 0.1 { // or some threshold suitable to your needs
                        self.scrollOffset = offset
                        self.lastScrollOffset = offset
                    }
                }
                
                
                
                .deletionAlert(showingAlert: $showingDeleteAlert, itemToDelete: $itemToDelete, deleteConfirmed: softDeleteConfirmed, context: viewContext)
                .onAppear {
                    updateNoDataPresentInRecycleBin()
                    showOverlay = false
                }
                
                
                
            
        }
                .navigationBarBackButtonHidden(true)
                .navigationViewStyle(StackNavigationViewStyle())
        }
        
        
        
    
    
    
    
    private var headerView: some View {
        
        let scale = max(min(1.0 + scrollOffset / 100, 1.0), 0.0)  // Adjust scale
        let opacity = max(min(1.0 + scrollOffset / 100, 1.0), 0.0)  // Adjust opacity
        
        return AnyView (
            HStack {
                Text("Events")
                    .mainHeaderStyle()
                
                Spacer()
                HStack {
                    
                    if isEditMode {
                        NavigationLink(destination: RecycleBinView().environment(\.managedObjectContext, viewContext)) {
                            Image(systemName: noDataPresentInRecycleBin ? "trash" : "trash.fill")
                                .foregroundColor(Color.green)
                                .font(.system(size: 24))
                                .padding(5)
                        }
                    } else {
                        Button(action: {
                            isEditMode = false // Disable edit mode when the '+' button is pressed.
                            isPresentingForm = true
                        }) {
                            Image(systemName: "plus.app")
                                .foregroundColor(Color.mainHeaderTextColor)
                                .font(.system(size: 24))
                                .padding(5)
                                .scaleEffect(noDataPresent ? 1.4 : 1.0)
                                .animation(noDataPresent ? Animation.easeInOut(duration: 1.0).repeatForever(autoreverses: true) : .default, value: noDataPresent)
                        }
                        .foregroundColor(Color.mainHeaderTextColor)
                        .sheet(isPresented: $isPresentingForm) {
                            NewDataEntryForm()
                                .environment(\.managedObjectContext, viewContext)
                        }
                    }
                    Button(isEditMode ? "Done" : "Edit") {
                        isEditMode.toggle()
                    }
                    .font(.custom("Quicksand-Bold", size: 16))
                    .foregroundColor(Color.mainHeaderTextColor)
                    .frame(minWidth: 60, maxWidth: 60, minHeight: 40, maxHeight: 40)  // Explicitly set frame
                }
            }
                .padding([.leading, .trailing], 8)
                .frame(height: 60 * scale)  // Scale the header frame
                .padding(.bottom, 0)
            
            
        )
        .opacity(Double(opacity))  // Adjust the opacity of the header text
    }
    
    
    
    private func deleteItem(item: Item) {
        prepareForDeletion(item: item, with: viewContext, showingAlert: &showingDeleteAlert, itemToDelete: &itemToDelete)
        updateNoDataPresentInRecycleBin()
        
    }
    
    private func updateNoDataPresentInRecycleBin() {
        let fetchRequest: NSFetchRequest<Item> = Item.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "taggedForDelete == %@", NSNumber(value: true))
        
        do {
            let recycleBinItems = try viewContext.fetch(fetchRequest)
            noDataPresentInRecycleBin = recycleBinItems.isEmpty
        } catch {
            print("Failed to fetch items from the recycle bin: \(error)")
        }
    }
    
    
    
}

struct ScrollOffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value += nextValue()
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
    }
}
