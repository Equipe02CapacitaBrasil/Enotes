//
//  ENotesApp.swift
//  ENotes
//
//  Created by iredefbmac_27 on 14/07/25.
//

import SwiftUI
import SwiftData

@main
struct ENotesApp: App {
    
    var container: ModelContainer = {
            let schema = Schema([Tasks.self])
            let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
            
            do {
                return try ModelContainer(for: schema, configurations: modelConfiguration)
            } catch {
                fatalError("Nao consegui criar o container de persistencia")
            }
        }()
    
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(container)
    }
}


