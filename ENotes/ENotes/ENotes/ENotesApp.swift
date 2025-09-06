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
    
    @AppStorage("AppStyle") private var appStyle : String = "system"
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(
                    appStyle == "light" ? .light :
                    appStyle == "dark" ? .dark :
                        nil)
                                      }
        .modelContainer(for : [Tasks.self, Notes.self])
    
    }
}


