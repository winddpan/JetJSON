//
//  JSONStatistics.swift
//  JetJSON
//
//  Created by winddpan on 8/2/25.
//

import Foundation

struct JSONStatistics {
    let characterCount: Int
    let fileSize: String
    let nodeCount: Int
    
    init(from text: String) {
        self.characterCount = text.count
        self.fileSize = ByteCountFormatter.string(fromByteCount: Int64(text.utf8.count), countStyle: .file)
        self.nodeCount = Self.countJSONNodes(in: text)
    }
    
    private static func countJSONNodes(in text: String) -> Int {
        guard let data = text.data(using: .utf8) else { return 0 }
        
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: [])
            return countNodes(in: json)
        } catch {
            return 0
        }
    }
    
    private static func countNodes(in value: Any) -> Int {
        switch value {
        case let dict as [String: Any]:
            return 1 + dict.values.reduce(0) { $0 + countNodes(in: $1) }
        case let array as [Any]:
            return 1 + array.reduce(0) { $0 + countNodes(in: $1) }
        default:
            return 1
        }
    }
}
