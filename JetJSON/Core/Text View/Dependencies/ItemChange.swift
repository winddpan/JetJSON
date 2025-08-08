//
//  ItemChange.swift
//
//  CotEditor
//  https://coteditor.com
//
//  Created by 1024jp on 2024-08-25.
//
//  ---------------------------------------------------------------------------
//
//  © 2024 1024jp
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

enum ItemChange<Item> {
    
    case added(_ name: Item)
    case removed(_ name: Item)
    case updated(from: Item, to: Item)
    
    
    /// The item before the change.
    var old: Item? {
        
        switch self {
            case .removed(let name), .updated(from: let name, to: _):
                name
            case .added:
                nil
        }
    }
    
    
    /// The item after the change.
    var new: Item? {
        
        switch self {
            case .added(let name), .updated(from: _, to: let name):
                name
            case .removed:
                nil
        }
    }
}
