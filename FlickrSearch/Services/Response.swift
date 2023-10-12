import Foundation

protocol Response {
    init(_ httpResponse: HTTPResponse) throws
}

protocol JsonResponse: Response, Decodable {
    static var decoder: JSONDecoder { get }
}

extension JsonResponse {
    init(_ httpResponse: HTTPResponse) throws {
        self = try Self.decoder.decode(Self.self, from: httpResponse.body)
    }
}
