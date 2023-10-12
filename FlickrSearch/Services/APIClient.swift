import Foundation

// MARK: - APIClient

protocol APIClient {
    // MARK: Methods

    /// Sends a request.
    func send(_ request: HTTPRequest) async throws -> HTTPResponse
}

// MARK: URLSession

extension URLSession: APIClient {
    func send(_ request: HTTPRequest) async throws -> HTTPResponse {
        let urlRequest = request.urlRequest

        let (data, urlResponse) = try await data(for: urlRequest)

        return try HTTPResponse(data: data, response: urlResponse)
    }
}
