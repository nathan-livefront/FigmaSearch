import Foundation

// MARK: - SearchService

/// An object that can be used to perform search queries with the Flickr API.
///
protocol SearchService: AnyObject {
    // MARK: Methods

    /// Retrieves a list of image results for the provided tags.
    ///
    /// - Parameter tags: A list of tags to search with.
    /// - Returns: A list of `ImageResult`s.
    ///
    func retrieveImages(for tags: [String]) async throws -> SearchResult
}

class DefaultSearchService: SearchService {
    var apiService: APIService

    init(apiService: APIService) {
        self.apiService = apiService
    }

    func retrieveImages(for tags: [String]) async throws -> SearchResult {
        print("Retrieving images for: \(tags)")
        let request = SearchRequest(tags: tags)
        let response = try await apiService.send(request: request)
        return response
    }
}
