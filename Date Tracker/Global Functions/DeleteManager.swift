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
    let deleteConfirmed: (Item) -> Void
    
    func body(content: Content) -> some View {
        content
            .alert(isPresented: $showingAlert) {
                Alert(title: Text("Delete Item"),
                      message: Text("Are you sure you want to delete this item?"),
                      primaryButton: .destructive(Text("Delete")) {
                        guard let item = itemToDelete else { return }
                        deleteConfirmed(item)
                      },
                      secondaryButton: .cancel())
            }
    }
}

extension View {
    func deletionAlert(showingAlert: Binding<Bool>, itemToDelete: Binding<Item?>, deleteConfirmed: @escaping (Item) -> Void) -> some View {
        self.modifier(DeletionAlertModifier(showingAlert: showingAlert, itemToDelete: itemToDelete, deleteConfirmed: deleteConfirmed))
    }
}

func prepareForDeletion(item: Item, with context: NSManagedObjectContext, showingAlert: inout Bool, itemToDelete: inout Item?) {
    itemToDelete = item
    showingAlert = true
}

func deleteConfirmed(item: Item, with context: NSManagedObjectContext) {
    withAnimation {
        context.delete(item)
        do {
            try context.save()
        } catch {
            print("Could not save context: \(error.localizedDescription)")
        }
    }
}
