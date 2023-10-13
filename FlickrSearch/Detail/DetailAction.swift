import Foundation

// MARK: - DetailAction

/// Actions that can be handled by a `DetailViewModel`.
enum DetailAction: Equatable {
    /// The dismiss button was pressed.
    case dismissPressed

    /// The show all tags button was pressed.
    case showAllTagsPressed

    /// The specified tag was pressed.
    case tagPressed(String)
}
