import Foundation

// MARK: - Resources+Models

extension Resources {
    /// A successful image result.
    static var imageResultSuccess: Data {
        get throws { try loadJsonFromDisk(filename: "ImageResultSuccess") }
    }

    /// A successful search result.
    static var searchResultSuccess: Data {
        get throws { try loadJsonFromDisk(filename: "SearchResultSuccess") }
    }
}
