//
//  Date_TrackerApp.swift
//  Date Tracker
//
//  Created by Cody McRoy on 8/26/23.
//

import SwiftUI

@main
struct Date_TrackerApp: App {
    let persistenceController = PersistenceController.shared
    
    init() {
        printFonts()
    }
    
    func printFonts() {
        let fontFamilyNames = UIFont.familyNames
        
        for familyName in fontFamilyNames {
            print("------------------------")
            print("Font Family name ---> [\(familyName)]")
            let names = UIFont.fontNames(forFamilyName: familyName)
            print("Font Names =======================> [\(names)]")
        }
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
