import Foundation

// MARK: - SearchResult

/// An object representing the results from performing a search on Flickr.
///
struct SearchResult: Codable {
    // MARK: Properties

    /// A description of this search result.
    var description: String

    /// The image results for this search result.
    var items: [ImageResult]

    /// A permalink to this search result on Flickr.
    var link: URL

    /// The date this search result was modified.
    var modified: Date

    /// The title of the search result.
    var title: String
}
