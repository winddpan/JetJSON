import CodableWrapper
import Foundation

extension SettingsData {
    @Codable
    struct ThemeSettings: Codable, Hashable {
        /// The appearance of the app
        var appAppearance: Appearances = .system

        var selectedTheme: String?
    }
}
