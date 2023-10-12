import Foundation

enum HTTPResponseError: Error {
    case invalidResponse
}

struct HTTPResponse: Equatable {
    let body: Data
    let headers: [String: String]
    let status: Int
}

extension HTTPResponse {
    init(data: Data, response: URLResponse) throws {
        guard let response = response as? HTTPURLResponse else {
            throw HTTPResponseError.invalidResponse
        }

        body = data
        headers = response.allHeaderFields as? [String: String] ?? [:]
        status = response.statusCode
    }
}
