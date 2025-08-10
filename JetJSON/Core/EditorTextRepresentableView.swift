//
//  EditorRepresentView.swift
//  JetJSON
//
//  Created by winddpan on 8/10/25.
//

import SwiftUI

struct EditorTextRepresentableView: NSViewControllerRepresentable {
    let textStorage: NSTextStorage
    let theme: Theme

    init(textStorage: NSTextStorage, theme: Theme) {
        self.textStorage = textStorage
        self.theme = theme
    }

    func makeNSViewController(context: Context) -> EditorTextViewController {
        EditorTextViewController(textStorage: textStorage)
    }

    func updateNSViewController(_ nsViewController: EditorTextViewController, context: Context) {
        nsViewController.theme = theme
    }
}
