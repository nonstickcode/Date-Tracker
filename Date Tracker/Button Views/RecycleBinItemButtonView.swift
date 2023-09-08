import SwiftUI
import CoreData



struct RecycleBinItemButtonView: View {
    var item: Item?
    
    
    @Binding var noDataPresentInRecycleBin: Bool
    
    @Environment(\.managedObjectContext) private var viewContext
    
    
    
    var body: some View {
        RoundedRectangle(cornerRadius: 8)
            .fill(Color.white)
            .frame(height: 80)
            .overlay(
                VStack(spacing: 3) {
                    if let item = item, let _ = item.eventDate {
                        
                        HStack {
                            Text("\(item.name ?? "") \(item.eventType ?? "") event")
                                .mainButtonTextStyle()
                            
                        }
                        
                        HStack {
                            if let dateTaggedForDelete = item.dateEventTaggedForDelete {
                                Text("Deleted on \(dateTaggedForDelete, formatter: dateFormatter)")
                                    .boldButtonRedTextStyle()
                                
                                
                            } else {
                                Text("No Date Tagged for Delete")
                                    .mainButtonTextStyle()
                            }
                        }
                        HStack {
                            Text("\(item.timeUntilHardDelete) days until DELETED")  // here is where its called in another file and displays not rounded or floored  see yearsUntil in GlobalFunctions was maybe affecting this rounding 
                                .boldButtonRedTextStyle()
                            
                        }
                    } else {
                        noDataView2
                    }
                }
            )
            .onAppear(perform: checkForTaggedForDeleteItems)
            .padding(.top, 8)
            .padding([.leading, .trailing], 16)
    }
    
    private func checkForTaggedForDeleteItems() {
        let fetchRequest: NSFetchRequest<Item> = Item.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "taggedForDelete == %@", NSNumber(value: true))
        
        do {
            let items = try viewContext.fetch(fetchRequest)
            if items.isEmpty {
                // No items are tagged for deletion
                noDataPresentInRecycleBin = true
            }
        } catch {
            print("Failed to fetch items: \(error)")
        }
    }
    
    
    private var noDataView2: some View {
        VStack {
            Spacer()
            Text("No data available")
                .emptyButtonBoldTextStyle()
            HStack {
                Text("Recycle Bin Empty")
                    .emptyButtonTextStyle()
                
            }
            Spacer()
        }
    }
    
}

