import Foundation

// MARK: - SearchState

/// An object representing the state for a `SearchView`.
struct SearchState {
    // MARK: Properties

    /// The text entered by the user in the search bar.
    var searchText: String = ""

    /// The results for the current search query.
    var results: [ImageResult] = []
}
