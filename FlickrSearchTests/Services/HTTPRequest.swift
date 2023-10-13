import XCTest

@testable import FlickrSearch

class HTTPRequestTests: XCTestCase {
    func test_urlRequest() {
        let subject = HTTPRequest(
            url: URL(string: "https://www.example.com")!,
            headers: ["name": "value"],
            body: Data("data time!".utf8),
            method: "GET"
        )
        let request = subject.urlRequest

        XCTAssertEqual(request.url, URL(string: "https://www.example.com"))
        XCTAssertEqual(request.allHTTPHeaderFields, ["name": "value"])
        XCTAssertEqual(request.httpBody, Data("data time!".utf8))
        XCTAssertEqual(request.httpMethod, "GET")
    }
}
