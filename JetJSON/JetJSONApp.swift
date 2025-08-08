//
//  JetJSONApp.swift
//  JetJSON
//
//  Created by winddpan on 8/2/25.
//

import SwiftUI

@main
struct JetJSONApp: App {
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
