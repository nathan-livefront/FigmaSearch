import Foundation

protocol Request {
    associatedtype Response

    var path: String { get }
    var body: Data? { get }
    var method: String { get }

    func url(from baseURL: URL) -> URL
}

struct JsonRequest<Response: Decodable>: Request {
    typealias Response = Response

    var path = ""
    var body: Data?
    var method = "GET"

    func url(from baseURL: URL) -> URL {
        baseURL.appending(path: path)
    }
}

protocol URLParameterRequest: Request {
    var parameters: [String: String] { get }
}

extension URLParameterRequest {
    func url(from baseURL: URL) -> URL {
        baseURL
            .appending(path: path)
            .appending(
                queryItems: parameters.map { URLQueryItem(name: $0, value: $1) }
            )
    }
}
