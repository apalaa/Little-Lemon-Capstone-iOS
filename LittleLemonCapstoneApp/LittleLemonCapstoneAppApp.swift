//
//  LittleLemonCapstoneAppApp.swift
//  LittleLemonCapstoneApp
//
//  Created by Angel Palaguachi on 10/22/24.
//

import SwiftUI

@main
struct LittleLemonCapstoneAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            Onboarding()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
