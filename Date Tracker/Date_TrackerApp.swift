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
    @State private var hasLaunched = false

    init() {
        printFonts()

        let context = persistenceController.container.viewContext
        cleanUpItems(with: context)
    }

    func printFonts() {
        let fontFamilyNames = UIFont.familyNames

        for familyName in fontFamilyNames {
            print("----------------------------------")
            print("Font Family name ---> [\(familyName)]")
            let names = UIFont.fontNames(forFamilyName: familyName)
            print("Font Names =============> [\(names)]")
        }
    }

    var body: some Scene {
        WindowGroup {
            if !hasLaunched {
                SplashScreenView()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { // total time SplashScreenView is present on screen
                            withAnimation {
                                hasLaunched = true
                            }
                        }
                    }
            } else {
                ContentView()
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
            }
        }
    }
}
