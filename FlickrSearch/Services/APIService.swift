import Foundation

// MARK: - APIService

/// An object used to interact with the Flickr API.
///
class APIService {
    // MARK: Properties

    var baseURL: URL

    var client: APIClient

    init(
        baseURL: URL,
        client: APIClient
    ) {
        self.baseURL = baseURL
        self.client = client
    }

    func send<R: Request>(request: R) async throws -> R.Response where R.Response: Response {
        let httpRequest = HTTPRequest(
            url: request.url(from: baseURL),
            body: request.body,
            method: request.method
        )
        let httpResponse = try await client.send(httpRequest)
        return try R.Response(httpResponse)
    }
}
