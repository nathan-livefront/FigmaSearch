import Foundation

// MARK: - DetailViewModel

/// A view model that handles `DetailAction`s.
///
class DetailViewModel: ViewModel<DetailAction, DetailState> {
    // MARK: Properties

    /// A closure that is called when the `.dismissPressed` action is received.
    var onDismiss: (() -> Void)?

    /// A closure that is called when the `.tagPressed` action is received.
    var onTagPressed: ((String) -> Void)?

    // MARK: Initialization

    /// Creates a `DetailViewModel`.
    ///
    /// - Parameters:
    ///   - onDismiss: A closure that is called when the `.dismissPressed` action is received.
    ///   - onTagPressed: A closure that is called when the `.tagPressed` action is received.
    ///   - state: The initial state of this view model.
    ///
    init(
        onDismiss: (() -> Void)? = nil,
        onTagPressed: ((String) -> Void)? = nil,
        state: DetailState
    ) {
        self.onDismiss = onDismiss
        self.onTagPressed = onTagPressed
        super.init(state: state)
    }

    // MARK: Methods

    override func receive(_ action: DetailAction) {
        switch action {
        case .dismissPressed:
            onDismiss?()
        case .showAllTagsPressed:
            state.areAllTagsDisplayed = true
        case let .tagPressed(newValue):
            onTagPressed?(newValue)
        }
    }
}
