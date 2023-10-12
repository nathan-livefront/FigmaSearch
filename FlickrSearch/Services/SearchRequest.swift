import Foundation

struct SearchRequest: URLParameterRequest {
    typealias Response = SearchResult

    var path: String
    var method: String
    var body: Data?
    var parameters: [String : String]

    init(tags: [String]) {
        path = ""
        method = "GET"
        body = nil
        parameters = [
            "format": "json",
            "nojsoncallback": "1",
            "tags": tags.joined(separator: ","),
        ]
    }
}
