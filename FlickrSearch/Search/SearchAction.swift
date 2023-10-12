// MARK: - SearchAction

/// A set of actions that can be handled by a `SearchProcessor`
enum SearchAction {
    /// The search bar's text was changed.
    case searchTextChanged(String)
}
