import AppKit
import Foundation
import LineEnding

final class EditorTextViewController: NSViewController, NSTextViewDelegate {
    private(set) var textView: EditorTextView!
    private var lineNumberView: LineNumberView!
    private var jsonHighlightEnabled: Bool = true
    var theme: Theme = .init() {
        didSet {
            if let tv = textView {
                tv.theme = theme
            }
            applyJSONHighlighting()
        }
    }

    private var visibleAreaObservers: [NSObjectProtocol] = []
    let textStorage: NSTextStorage

    required init(textStorage: NSTextStorage) {
        self.textStorage = textStorage
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Lifecycle

    override func loadView() {
        // minimal editable text view
        let lineEndingScanner = LineEndingScanner(textStorage: textStorage, lineEnding: .lf)
        let textView = EditorTextView(textStorage: textStorage, lineEndingScanner: lineEndingScanner)
        textView.delegate = self

        let scrollView = NSScrollView()
        scrollView.hasVerticalScroller = true
        scrollView.documentView = textView
        scrollView.identifier = NSUserInterfaceItemIdentifier("EditorScrollView")

        let lineNumberView = LineNumberView()
        lineNumberView.textView = textView

        let stackView = NSStackView(views: [lineNumberView, scrollView])
        stackView.spacing = 0
        stackView.distribution = .fill

        view = stackView
        self.lineNumberView = lineNumberView
        self.textView = textView
        textView.theme = theme

        // Observe visible area changes (scroll/resize) to re-apply highlight
        let contentView = scrollView.contentView
        contentView.postsBoundsChangedNotifications = true
        let token = NotificationCenter.default.addObserver(forName: NSView.boundsDidChangeNotification, object: contentView, queue: .main) { [weak self] _ in
            self?.applyJSONHighlighting()
        }
        visibleAreaObservers.append(token)

        textView.postsFrameChangedNotifications = true
        let frameToken = NotificationCenter.default.addObserver(forName: NSView.frameDidChangeNotification, object: textView, queue: .main) { [weak self] _ in
            self?.applyJSONHighlighting()
        }
        visibleAreaObservers.append(frameToken)

        applyJSONHighlighting()
    }

    deinit {
        for token in self.visibleAreaObservers {
            NotificationCenter.default.removeObserver(token)
        }
        self.visibleAreaObservers.removeAll()
    }

    // MARK: Public Methods

    /// The visibility of the line number view.
    var showsLineNumber: Bool {
        get { lineNumberView?.isHidden == false }
        set { lineNumberView?.isHidden = !newValue }
    }

    /// Enable or disable JSON syntax highlighting.
    func setJSONHighlightingEnabled(_ enabled: Bool) {
        jsonHighlightEnabled = enabled
        applyJSONHighlighting()
    }

    /// Apply a custom theme to the editor.
    func applyTheme(_ theme: Theme) {
        self.theme = theme
    }

    /// Load and apply a custom theme from file URL (JSON encoded Theme).
    func applyTheme(from url: URL) throws {
        let theme = try Theme(contentsOf: url)
        applyTheme(theme)
    }

    // MARK: NSTextViewDelegate

    func textDidChange(_ notification: Notification) {
        applyJSONHighlighting()
    }

    // MARK: Private

    private func applyJSONHighlighting() {
        guard jsonHighlightEnabled, let layoutManager = textView.layoutManager else { return }

        // Only process visible range for performance
        guard let visibleRange = textView.visibleRange else { return }
        layoutManager.removeTemporaryAttribute(.foregroundColor, forCharacterRange: visibleRange)

        let stringColor = theme.strings.color
        let numberColor = theme.numbers.color
        let valueColor = theme.values.color // for true/false/null
        let keyColor = theme.attributes.color // use attributes color for JSON keys

        // Patterns
        // Keys: quoted string followed by optional spaces and a colon
        let keyPattern = #"\"(?:\\.|[^\"\\])*\"(?=\s*:)"#
        // Strings: generic quoted strings
        let stringPattern = #"\"(?:\\.|[^\"\\])*\""#
        // Numbers
        let numberPattern = #"-?(?:0|[1-9]\d*)(?:\.\d+)?(?:[eE][+-]?\d+)?"#
        // true | false | null
        let valuePattern = #"\b(?:true|false|null)\b"#

        func highlight(pattern: String, color: NSColor) {
            guard let regex = try? NSRegularExpression(pattern: pattern, options: []) else { return }
            let matches = regex.matches(in: textView.string, options: [], range: visibleRange)
            for match in matches {
                layoutManager.addTemporaryAttribute(.foregroundColor, value: color, forCharacterRange: match.range)
            }
        }

        // First, highlight all strings and collect ranges to avoid highlighting numbers/keywords inside strings.
        guard let stringRegex = try? NSRegularExpression(pattern: stringPattern, options: []) else { return }
        let stringMatches = stringRegex.matches(in: textView.string, options: [], range: visibleRange)
        for match in stringMatches {
            layoutManager.addTemporaryAttribute(.foregroundColor, value: stringColor, forCharacterRange: match.range)
        }

        func isInsideString(_ range: NSRange) -> Bool {
            for m in stringMatches {
                if m.range.intersection(range) != nil { return true }
            }
            return false
        }

        // Then highlight numbers and keywords excluding ranges inside strings.
        if let numberRegex = try? NSRegularExpression(pattern: numberPattern, options: []) {
            for match in numberRegex.matches(in: textView.string, options: [], range: visibleRange) {
                if !isInsideString(match.range) {
                    layoutManager.addTemporaryAttribute(.foregroundColor, value: numberColor, forCharacterRange: match.range)
                }
            }
        }
        if let valueRegex = try? NSRegularExpression(pattern: valuePattern, options: []) {
            for match in valueRegex.matches(in: textView.string, options: [], range: visibleRange) {
                if !isInsideString(match.range) {
                    layoutManager.addTemporaryAttribute(.foregroundColor, value: valueColor, forCharacterRange: match.range)
                }
            }
        }

        // Finally, overwrite keys to key color.
        // Highlight keys in visible range
        func highlightInVisible(pattern: String, color: NSColor) {
            guard let regex = try? NSRegularExpression(pattern: pattern, options: []) else { return }
            let matches = regex.matches(in: textView.string, options: [], range: visibleRange)
            for match in matches {
                layoutManager.addTemporaryAttribute(.foregroundColor, value: color, forCharacterRange: match.range)
            }
        }
        highlightInVisible(pattern: keyPattern, color: keyColor)
    }
}
