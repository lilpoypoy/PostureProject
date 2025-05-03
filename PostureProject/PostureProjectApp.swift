//
//  PostureProjectApp.swift
//  PostureProject
//
//  Created by Noah M on 2/27/25.
//

import SwiftUI
import SwiftData

@main
struct PostureProjectApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .aspectRatio(16/9, contentMode: .fit)
        }
        .modelContainer(sharedModelContainer)
        .windowResizability(.contentSize)
    }
}
