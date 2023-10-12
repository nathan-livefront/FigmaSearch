import Foundation

struct HTTPRequest: Equatable {
    var url: URL
    var headers: [String: String] = [:]
    var body: Data?
    var method: String
}

extension HTTPRequest {
    var urlRequest: URLRequest {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method
        urlRequest.httpBody = body

        for (field, value) in headers {
            urlRequest.addValue(value, forHTTPHeaderField: field)
        }

        return urlRequest
    }
}
