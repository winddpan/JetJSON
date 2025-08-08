//
//  JSONFormatter.swift
//  JetJSON
//
//  Created by winddpan on 8/3/25.
//

import Foundation

struct JSONFormatter {
    func format(_ jsonString: String, sortKey: Bool, indent: String = "  ",) throws -> String {
        let jsonObject = try JSONSerialization.jsonObject(with: jsonString.data(using: .utf8)!, options: .allowFragments)
        return prettyFormat(value: jsonObject, sortKey: sortKey, indentLevel: 0, indentString: indent)
    }

    private func prettyFormat(value: Any, sortKey: Bool, indentLevel: Int, indentString: String) -> String {
        let currentIndent = String(repeating: indentString, count: indentLevel)
        let nextIndent = String(repeating: indentString, count: indentLevel + 1)

        switch value {
        case let dict as [String: Any]:
            if dict.isEmpty {
                return "{}"
            }

            let kvs = sortKey ? dict.sorted(by: { $0.key < $1.key }) : dict.map { $0 }
            let members = kvs.map { key, val in
                let formattedValue = prettyFormat(value: val, sortKey: sortKey, indentLevel: indentLevel + 1, indentString: indentString)
                // 这里是关键：": " 冒号后加了一个空格
                return "\(nextIndent)\"\(key)\": \(formattedValue)"
            }

            // 3. 用逗号和换行符将所有成员连接起来
            return "{\n" + members.joined(separator: ",\n") + "\n\(currentIndent)}"

        case let array as [Any]:
            if array.isEmpty {
                return "[]"
            }

            // 1. 将数组的每个元素映射为一个格式化好的字符串
            let items = array.map { item in
                let formattedItem = prettyFormat(value: item, sortKey: sortKey, indentLevel: indentLevel + 1, indentString: indentString)
                return "\(nextIndent)\(formattedItem)"
            }

            // 2. 用逗号和换行符将所有元素连接起来
            return "[\n" + items.joined(separator: ",\n") + "\n\(currentIndent)]"

        case let str as String:
            // 对字符串中的特殊字符进行转义
            return "\"\(str)\""

        case let num as NSNumber:
            // 处理 Bool 和数字类型
            if num === kCFBooleanTrue as NSNumber {
                return "true"
            } else if num === kCFBooleanFalse as NSNumber {
                return "false"
            }
            return num.stringValue

        case is NSNull:
            return "null"

        default:
            // 对于其他未知类型，直接转换为字符串（兜底方案）
            return "\(value)"
        }
    }
}

/// 用于转义字符串中特殊字符的辅助扩展
private extension String {
    func escapingSpecialCharacters() -> String {
        var a = self
        a = a.replacingOccurrences(of: "\\", with: "\\\\")
        a = a.replacingOccurrences(of: "\"", with: "\\\"")
        a = a.replacingOccurrences(of: "/", with: "\\/")
        a = a.replacingOccurrences(of: "\n", with: "\\n")
        a = a.replacingOccurrences(of: "\r", with: "\\r")
        a = a.replacingOccurrences(of: "\t", with: "\\t")
        // U+0008 (Backspace)
        a = a.replacingOccurrences(of: "\u{0008}", with: "\\b")
        // U+000C (Form Feed)
        a = a.replacingOccurrences(of: "\u{000C}", with: "\\f")
        return a
    }
}
