import XCTest

@testable import FigmaSearch

// MARK: - SearchResultTests

class SearchResultTests: XCTestCase {
    // MARK: Tests

    func test_decode_success() throws {
        let json = try Resources.searchResultSuccess
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601
        let subject = try decoder.decode(SearchResult.self, from: json)

        XCTAssertEqual(subject.title, "Recent Uploads tagged porcupine")
        XCTAssertEqual(subject.link, URL(string: "https://www.flickr.com/photos/tags/porcupine/"))
        XCTAssertEqual(subject.description, "")
        XCTAssertEqual(subject.modified, try Date("2023-10-11T04:10:29Z", strategy: .iso8601))
        XCTAssertEqual(subject.items.count, 17)
    }
}
