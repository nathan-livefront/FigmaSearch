import XCTest

@testable import FlickrSearch

class SearchServiceTests: XCTestCase {
    var apiService: APIService!
    var client: MockClient!
    var subject: DefaultSearchService!

    override func setUp() {
        super.setUp()
        client = MockClient()
        apiService = APIService(
            baseURL: URL(string: "https://www.example.com")!,
            client: client
        )
        subject = DefaultSearchService(apiService: apiService)
    }

    override func tearDown() {
        super.tearDown()
        apiService = nil
        client = nil
        subject = nil
    }

    // MARK: Tests

    func test_retrieveImages_withOneTag() async throws {
        client.results = [.success(.init(body: try Resources.searchResultSuccess, headers: [:], status: 200))]
        let result = try await subject.retrieveImages(for: ["tag1"])

        XCTAssertEqual(client.requests.count, 1)

        XCTAssertEqual(result.title, "Recent Uploads tagged porcupine")
        XCTAssertEqual(result.link, URL(string: "https://www.flickr.com/photos/tags/porcupine/"))
        XCTAssertEqual(result.description, "")
        XCTAssertEqual(result.modified, try Date("2023-10-11T04:10:29Z", strategy: .iso8601))
        XCTAssertEqual(result.items.count, 17)

        let request = client.requests[0]
        let urlComponents = URLComponents(url: request.url, resolvingAgainstBaseURL: false)!
        var queryItems: [String: String] = [:]
        for item in urlComponents.queryItems! {
            queryItems[item.name] = item.value
        }

        XCTAssertEqual(queryItems, [
            "tags": "tag1",
            "nojsoncallback": "1",
            "format": "json"
        ])
        XCTAssertNil(request.body)
        XCTAssertEqual(request.method, "GET")
        XCTAssertEqual(request.headers, [:])
    }

    func test_retrieveImages_withMultipleTags() async throws {
        client.results = [.success(.init(body: try Resources.searchResultSuccess, headers: [:], status: 200))]
        let result = try await subject.retrieveImages(for: ["tag1", "tag2", "tag3"])

        XCTAssertEqual(client.requests.count, 1)

        XCTAssertEqual(result.title, "Recent Uploads tagged porcupine")
        XCTAssertEqual(result.link, URL(string: "https://www.flickr.com/photos/tags/porcupine/"))
        XCTAssertEqual(result.description, "")
        XCTAssertEqual(result.modified, try Date("2023-10-11T04:10:29Z", strategy: .iso8601))
        XCTAssertEqual(result.items.count, 17)

        let request = client.requests[0]
        let urlComponents = URLComponents(url: request.url, resolvingAgainstBaseURL: false)!
        var queryItems: [String: String] = [:]
        for item in urlComponents.queryItems! {
            queryItems[item.name] = item.value
        }

        XCTAssertEqual(queryItems, [
            "tags": "tag1,tag2,tag3",
            "nojsoncallback": "1",
            "format": "json"
        ])
        XCTAssertNil(request.body)
        XCTAssertEqual(request.method, "GET")
        XCTAssertEqual(request.headers, [:])
    }
}
