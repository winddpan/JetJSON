//
//  MultipleReplacePanelController.swift
//
//  CotEditor
//  https://coteditor.com
//
//  Created by 1024jp on 2023-01-03.
//
//  ---------------------------------------------------------------------------
//
//  © 2023-2024 1024jp
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  https://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

import AppKit

final class MultipleReplacePanelController: NSWindowController {
    
    // MARK: Public Properties
    
    static let shared = MultipleReplacePanelController()
    
    
    // MARK: Lifecycle
    
    convenience init() {
        
        let window = NSPanel(contentViewController: MultipleReplaceSplitViewController())
        window.styleMask = [.titled, .closable, .resizable, .fullSizeContentView, .utilityWindow]
        window.level = .floating
        window.titlebarAppearsTransparent = true
        window.standardWindowButton(.zoomButton)?.isEnabled = false
        window.setFrameAutosaveName("Multiple Replace Panel")
        window.title = String(localized: "Multiple Replace", table: "MultipleReplace", comment: "window title")
        
        self.init(window: window)
    }
}
