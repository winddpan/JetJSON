//
//  ContentView.swift
//  JsonZen
//
//  Created by winddpan on 8/2/25.
//

import CodeEditLanguages
import CodeEditSourceEditor
import CodeEditTextView
import SwiftUI

struct ContentView: View {
    @State private var text = testJSON
    @State private var highlighter = JSONSyntaxHighlighter()
    @State private var language: CodeLanguage = .json
    @State private var theme: EditorTheme = .system
    @State private var editorState = SourceEditorState(
        cursorPositions: []
    )
    @State private var font: NSFont = .monospacedSystemFont(ofSize: 12, weight: .medium)
    @State private var indentOption: IndentOption = .spaces(count: 4)
    @State private var invisibleCharactersConfig: InvisibleCharactersConfiguration = .empty
    @State private var warningCharacters: Set<UInt16> = []

    @AppStorage("reformatAtColumn") private var reformatAtColumn: Int = 80
    @AppStorage("showGutter") private var showGutter: Bool = true
    @AppStorage("showMinimap") private var showMinimap: Bool = false
    @AppStorage("showReformattingGuide") private var showReformattingGuide: Bool = false
    @AppStorage("showFoldingRibbon") private var showFoldingRibbon: Bool = true
    @AppStorage("wrapLines") private var wrapLines: Bool = true

    var body: some View {
        SourceEditor(
            $text,
            language: language,
            configuration: SourceEditorConfiguration(
                appearance: .init(theme: theme, font: font, wrapLines: wrapLines),
                behavior: .init(
                    indentOption: indentOption,
                    reformatAtColumn: reformatAtColumn
                ),
                peripherals: .init(
                    showGutter: showGutter,
                    showMinimap: showMinimap,
                    showReformattingGuide: showReformattingGuide,
                    invisibleCharactersConfiguration: invisibleCharactersConfig,
                    warningCharacters: warningCharacters
                )
            ),
            state: $editorState,
            highlightProviders: [highlighter],
            completionDelegate: nil
        )
    }
}

#Preview {
    ContentView()
}
