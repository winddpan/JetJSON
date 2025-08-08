//
//  Pair.swift
//  StringUtils
//
//  CotEditor
//  https://coteditor.com
//
//  Created by 1024jp on 2016-08-19.
//
//  ---------------------------------------------------------------------------
//
//  © 2016-2024 1024jp
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

public struct Pair<T> {
    
    public var begin: T
    public var end: T
    
    
    public init(_ begin: T, _ end: T) {
        
        self.begin = begin
        self.end = end
    }
}


extension Pair: Equatable where T: Equatable { }
extension Pair: Hashable where T: Hashable { }
extension Pair: Sendable where T: Sendable { }
