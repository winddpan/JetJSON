//
//  EditorRepresentView.swift
//  JetJSON
//
//  Created by winddpan on 8/10/25.
//

import SwiftUI

struct EditorTextSwiftUIView: NSViewControllerRepresentable {
    func makeNSViewController(context: Context) -> EditorTextViewController {
        EditorTextViewController()
    }

    func updateNSViewController(_ nsViewController: EditorTextViewController, context: Context) {}
}
