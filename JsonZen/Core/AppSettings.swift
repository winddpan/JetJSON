//
//  AppSettings.swift
//  JsonZen
//
//  Created by winddpan on 8/2/25.
//

import Foundation

enum HighlightThemeType: String, CaseIterable {
    case defaultTheme = "default"
    case darkTheme = "dark"
    case monochromeTheme = "monochrome"

    var displayName: String {
        switch self {
        case .defaultTheme:
            return "默认主题"
        case .darkTheme:
            return "深色主题"
        case .monochromeTheme:
            return "单色主题"
        }
    }
}

class AppSettings: ObservableObject {
    static let shared = AppSettings()

    private let userDefaults = UserDefaults.standard

    @Published var highlightTheme: HighlightThemeType {
        didSet {
            userDefaults.set(highlightTheme.rawValue, forKey: "highlightTheme")
        }
    }

    @Published var showLineNumbers: Bool {
        didSet {
            userDefaults.set(showLineNumbers, forKey: "showLineNumbers")
        }
    }

    @Published var associateJsonFiles: Bool {
        didSet {
            userDefaults.set(associateJsonFiles, forKey: "associateJsonFiles")
        }
    }

    @Published var autoFormat: Bool {
        didSet {
            userDefaults.set(autoFormat, forKey: "autoFormat")
        }
    }

    private init() {
        highlightTheme = HighlightThemeType(rawValue: userDefaults.string(forKey: "highlightTheme") ?? "default") ?? .defaultTheme
        showLineNumbers = userDefaults.bool(forKey: "showLineNumbers")
        associateJsonFiles = userDefaults.bool(forKey: "associateJsonFiles")
        autoFormat = userDefaults.bool(forKey: "autoFormat")

        setupDefaultValues()
    }

    private func setupDefaultValues() {
        if userDefaults.object(forKey: "showLineNumbers") == nil {
            showLineNumbers = true
        }
        if userDefaults.object(forKey: "associateJsonFiles") == nil {
            associateJsonFiles = false
        }
        if userDefaults.object(forKey: "autoFormat") == nil {
            autoFormat = false
        }
    }
}
