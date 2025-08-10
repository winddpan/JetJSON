import AppKit
import LineEnding

final class EditorTextViewController: NSViewController, NSTextViewDelegate {

    // MARK: Public Properties

    private(set) var textView: EditorTextView!
    private var lineNumberView: LineNumberView!

    // MARK: Lifecycle

    override func loadView() {

        // minimal editable text view
        let textStorage = NSTextStorage()
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

        self.view = stackView
        self.lineNumberView = lineNumberView
        self.textView = textView
    }

    // MARK: Public Methods

    /// The visibility of the line number view.
    var showsLineNumber: Bool {
        get { self.lineNumberView?.isHidden == false }
        set { self.lineNumberView?.isHidden = !newValue }
    }
}
