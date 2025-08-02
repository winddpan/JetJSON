//
//  Settings.swift
//  CodeEditModules/Settings
//
//  Created by Lukas Pistrol on 01.04.22.
//

import CodableWrapper
import Foundation
import SwiftUI

/// # Settings
///
/// A `JSON` representation is persisted in `~/Library/Application Support/App/preference.json`.
/// - Attention: Don't use `UserDefaults` for persisting user accessible settings.
///  If a further setting is needed, extend the struct like ``GeneralSettings``,
///  ``ThemeSettings``,  or ``TerminalSettings`` does.
@Codable
struct SettingsData: Codable, Hashable {
    /// The general global settings
    var general: GeneralSettings = .init()

    /// The global settings for themes
    var theme: ThemeSettings = .init()

    /// The global settings for text editing
    var textEditing: TextEditingSettings = .init()
//
//    /// The global settings for the terminal emulator
//    var terminal: TerminalSettings = .init()
//
//    /// The global settings for source control
//    var sourceControl: SourceControlSettings = .init()
//
//    /// The global settings for keybindings
//    var keybindings: KeybindingsSettings = .init()
//
//    /// Search Settings
//    var search: SearchSettings = .init()
//
//    /// Language Server Settings
//    var languageServers: LanguageServerSettings = .init()
//
//    /// Developer settings for CodeEdit developers
//    var developerSettings: DeveloperSettings = .init()
}
