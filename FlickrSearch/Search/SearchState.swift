import Foundation

// MARK: - SearchState

/// An object representing the state for a `SearchView`.
struct SearchState {
    // MARK: Properties

    /// The text entered by the user in the search bar.
    var searchText: String = ""

    /// The results for the current search query.
    var results: [ImageResult] = []

    /// The image result that is being presented in the detail view.
    var imageResultPresentedInDetail: ImageResult?

    /// A flag indicating if the detail screen is presented.
    var isDetailPresented: Bool { imageResultPresentedInDetail != nil }
}
