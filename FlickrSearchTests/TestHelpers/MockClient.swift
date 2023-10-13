@testable import FlickrSearch

class MockClient: APIClient {
    var requests: [HTTPRequest] = []
    var results: [Result<HTTPResponse, Error>] = []

    func send(_ request: HTTPRequest) async throws -> HTTPResponse {
        requests.append(request)
        return try results.removeFirst().get()
    }
}
