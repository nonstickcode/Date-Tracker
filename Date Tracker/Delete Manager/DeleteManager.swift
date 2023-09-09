//
//  DeleteManager.swift
//  Date Tracker
//
//  Created by Cody McRoy on 9/7/23.
//

import SwiftUI
import CoreData

struct DeletionAlertModifier: ViewModifier {
    @Binding var showingAlert: Bool
    @Binding var itemToDelete: Item?
    let deleteConfirmed: (Item, NSManagedObjectContext) -> Void
    let context: NSManagedObjectContext
    
    func body(content: Content) -> some View {
        content
            .alert(isPresented: $showingAlert) {
                Alert(title: Text("Delete Item"),
                      message: Text("Are you sure you want to delete this item?"),
                      primaryButton: .destructive(Text("Delete")) {
                        guard let item = itemToDelete else { return }
                        deleteConfirmed(item, context)
                      },
                      secondaryButton: .cancel())
            }
    }
}

extension View {
    func deletionAlert(showingAlert: Binding<Bool>, itemToDelete: Binding<Item?>, deleteConfirmed: @escaping (Item, NSManagedObjectContext) -> Void, context: NSManagedObjectContext) -> some View {
        self.modifier(DeletionAlertModifier(showingAlert: showingAlert, itemToDelete: itemToDelete, deleteConfirmed: deleteConfirmed, context: context))
    }
}


func prepareForDeletion(item: Item, with context: NSManagedObjectContext, showingAlert: inout Bool, itemToDelete: inout Item?) {
    itemToDelete = item
    showingAlert = true
}

func softDeleteConfirmed(item: Item, with context: NSManagedObjectContext) {
    withAnimation {
        item.taggedForDelete = true
        item.dateEventTaggedForDelete = Date()
        do {
            try context.save()
        } catch {
            print("Could not save context: \(error.localizedDescription)")
        }
    }
}

// Restore function ------------------------------------------------------------------------------------------------

func restoreItem(item: Item, with context: NSManagedObjectContext) {
    withAnimation {
        item.taggedForDelete = false
        item.dateEventTaggedForDelete = nil
        do {
            try context.save()
        } catch {
            print("Could not save context: \(error.localizedDescription)")
        }
    }
}

// Clean up function ------------------------------------------------------------------------------------------------
// Runs everytime the app launches then also whenever RecycleBinView is shown

func cleanUpItems(with context: NSManagedObjectContext) {
    let fetchRequest: NSFetchRequest<Item> = Item.fetchRequest()
    fetchRequest.predicate = NSPredicate(format: "taggedForDelete == %@", NSNumber(value: true))
    
    // Hardcoded days until hard delete; change this value as needed
    let daysUntilHardDelete: Double = 30  // <-------------------------------- Change this number as per your requirements in DAYS
    
    do {
        let items = try context.fetch(fetchRequest)
        
        let currentDate = Date()
        
        for item in items {
            if let taggedDate = item.dateEventTaggedForDelete {
                let timeIntervalPassed = currentDate.timeIntervalSince(taggedDate)
                let daysPassed: Double = timeIntervalPassed / (60 * 60 * 24)
                
                // Calculate remaining days until hard delete on the item
                let remainingTime = max(0.0, daysUntilHardDelete - daysPassed)
                
                // Rounding to 3 decimal places
                let roundedRemainingTime = round(1000000 * remainingTime) / 1000000  // this limits the double to 6 decimal places, adding another 0 to each increases by 1 place
                
                // Update item attribute
                item.timeUntilHardDelete = roundedRemainingTime
                
                // Delete the item if the number of days passed reaches or exceeds the hardcoded daysUntilHardDelete
                if daysPassed >= daysUntilHardDelete {
                    context.delete(item)
                }
            }
        }
        
        try context.save()
        
    } catch {
        print("Could not fetch or delete items: \(error.localizedDescription)")
    }
}

// Clean up function end --------------------------------------------------------------------------------------------




