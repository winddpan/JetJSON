//
//  DefaultOptions.swift
//
//  CotEditor
//  https://coteditor.com
//
//  Created by 1024jp on 2017-02-14.
//
//  ---------------------------------------------------------------------------
//
//  © 2017-2024 1024jp
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

import Foundation.NSObjCRuntime
import Defaults

enum NoDocumentOnLaunchOption: Int, CaseIterable {
    
    case untitledDocument
    case openPanel
    case none
}


enum DocumentConflictOption: Int, CaseIterable {
    
    case ignore
    case notify
    case revert
}


enum WritingDirection: Int, CaseIterable {
    
    case leftToRight
    case rightToLeft
    case vertical
}


enum AppearanceMode: Int, CaseIterable {
    
    case `default`
    case light
    case dark
}


@objc enum PrintInfoType: Int, CaseIterable, DefaultInitializable {
    
    static let defaultValue: Self = .none
    
    case none
    case syntaxName
    case documentName
    case filePath
    case printDate
    case pageNumber
    case lastModifiedDate
}


@objc enum AlignmentType: Int, CaseIterable, DefaultInitializable {
    
    static let defaultValue: Self = .right
    
    case left
    case center
    case right
}
