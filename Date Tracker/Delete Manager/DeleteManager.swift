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

// Clean up function ------------------------------------------------------------------------------------------------

func cleanUpItems(with context: NSManagedObjectContext) {
    let fetchRequest: NSFetchRequest<Item> = Item.fetchRequest()
    fetchRequest.predicate = NSPredicate(format: "taggedForDelete == %@", NSNumber(value: true))
    
    do {
        let items = try context.fetch(fetchRequest)
        
        let currentDate = Date()
        
        for item in items {
            if let taggedDate = item.dateEventTaggedForDelete {
                if Calendar.current.dateComponents([.day], from: taggedDate, to: currentDate).day! >= 1 { // sets days to wait for delete
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
