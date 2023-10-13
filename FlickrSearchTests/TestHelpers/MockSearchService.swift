@testable import FlickrSearch

class MockSearchService: SearchService {
    var retrieveImagesCount = 0
    var retrieveImagesResult: Result<SearchResult, Error> = .failure(ExampleError.example)

    func retrieveImages(for tags: [String]) async throws -> SearchResult {
        retrieveImagesCount += 1
        return try retrieveImagesResult.get()
    }
}
