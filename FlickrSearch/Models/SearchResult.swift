import Foundation

// MARK: - SearchResult

/// An object representing the results from performing a search on Flickr.
///
struct SearchResult: Codable, Equatable, JsonResponse {
    // MARK: Type Properties

    static let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }()

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

extension SearchResult {
    static var fixture: Self {
        Self.init(
            description: "description",
            items: [.fixture],
            link: URL(string: "https://www.example.com")!,
            modified: try! Date("2023-10-08T08:42:00-08:00", strategy: .iso8601),
            title: "title"
        )
    }
}
