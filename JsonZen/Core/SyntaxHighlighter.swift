//
//  SyntaxHighlighter.swift
//  JsonZen
//
//  Created by winddpan on 8/2/25.
//

import AppKit
import CodeEditLanguages
import CodeEditSourceEditor
import CodeEditTextView
import Foundation

class JSONSyntaxHighlighter: HighlightProviding {
    private weak var textView: TextView?
    private var codeLanguage: CodeLanguage?

    init() {}

    // MARK: - HighlightProviding Implementation

    @MainActor
    func setUp(textView: TextView, codeLanguage: CodeLanguage) {
        self.textView = textView
        self.codeLanguage = codeLanguage
    }

    @MainActor
    func willApplyEdit(textView: TextView, range: NSRange) {
        // Optional method - using default implementation
    }

    @MainActor
    func applyEdit(
        textView: TextView,
        range: NSRange,
        delta: Int,
        completion: @escaping @MainActor (Result<IndexSet, Error>) -> Void
    ) {
        // For simplicity, invalidate the entire document for re-highlighting
        let invalidationRange = IndexSet(integersIn: 0 ..< textView.string.count)
        completion(.success(invalidationRange))
    }

    @MainActor
    func queryHighlightsFor(
        textView: TextView,
        range: NSRange,
        completion: @escaping @MainActor (Result<[HighlightRange], Error>) -> Void
    ) {
        let text = textView.string

        var highlights: [HighlightRange] = []

        // JSON Key pattern
        let keyPattern = #""[^"\\]*(?:\\.[^"\\]*)*"\s*(?=:)"#
        highlights.append(contentsOf: findMatches(pattern: keyPattern, in: text, range: range, capture: .property))

        // JSON String pattern
        let stringPattern = #":\s*("((?:[^"\\]|\\.)*)")"#
        highlights.append(contentsOf: findMatches(pattern: stringPattern, in: text, range: range, capture: .string))

        // JSON Number pattern
        let numberPattern = #"-?(?:0|[1-9]\d*)(?:\.\d+)?(?:[eE][+-]?\d+)?"#
        highlights.append(contentsOf: findMatches(pattern: numberPattern, in: text, range: range, capture: .number))

        // JSON Keywords pattern
        let keywordPattern = #"\b(?:true|false|null)\b"#
        highlights.append(contentsOf: findMatches(pattern: keywordPattern, in: text, range: range, capture: .boolean))

        highlights = highlights.sorted(by: {
            $0.range.location < $1.range.location
        })

        completion(.success(highlights))
    }

    private func findMatches(pattern: String, in text: String, range: NSRange, capture: CaptureName) -> [HighlightRange] {
        do {
            let regex = try NSRegularExpression(pattern: pattern, options: [])
            let matches = regex.matches(in: text, options: [], range: range)
            return matches.map { match in
                var range = match.range
                if capture == .string {
                    range = match.numberOfRanges > 1 ? match.range(at: 1) : match.range
                }
                // print("\(capture)", match.numberOfRanges, (text as NSString).substring(with: range))
                return HighlightRange(range: range, capture: capture)
            }
        } catch {
            print("Error creating regex for pattern \(pattern): \(error)")
            return []
        }
    }
}
