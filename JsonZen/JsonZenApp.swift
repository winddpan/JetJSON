//
//  JsonZenApp.swift
//  JsonZen
//
//  Created by winddpan on 8/2/25.
//

import SwiftUI

@main
struct JsonZenApp: App {
    @State private var showingSettings = false

    var body: some Scene {
        WindowGroup {
            ContentView()
        }

        Settings {
            SettingsView()
        }
    }
}
