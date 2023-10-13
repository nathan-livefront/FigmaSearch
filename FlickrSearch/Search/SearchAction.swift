// MARK: - SearchAction

/// A set of actions that can be handled by a `SearchViewModel`
enum SearchAction: Equatable {
    /// The dismiss button was pressed in the detail screen.
    case dismissDetail

    /// An image in the search results was pressed.
    case imagePressed(ImageResult)

    /// The search bar's text was changed.
    case searchTextChanged(String)

    /// A tag was selected.
    case tagSelected(String)
}
