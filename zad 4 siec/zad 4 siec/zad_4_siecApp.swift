//
//  zad_4_siecApp.swift
//  zad 4 siec
//
//  Created by user270910 on 1/22/25.
//

import SwiftUI

@main
struct zad_4_siecApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
