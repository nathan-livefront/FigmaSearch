import Foundation

// MARK: - ResourcesError

/// Errors that can occur when loading a file from disk.
///
enum ResourcesError: LocalizedError {
    /// The specified filename was unable to be located in this bundle.
    ///
    /// - Parameter filename: The name of the file that was desired.
    ///
    case fileNotFound(filename: String)

    var errorDescription: String? {
        switch self {
        case let .fileNotFound(filename):
            return "The file \(filename).json was not located in the bundle."
        }
    }
}

class Resources {
    /// Loads a json file from disk.
    ///
    /// - Parameter filename: The name of the file that should be retrieved, minus the `.json` extension.
    ///
    static func loadJsonFromDisk(filename: String) throws -> Data {
        let bundle = Bundle(for: Self.self)
        guard let url = bundle.url(forResource: filename, withExtension: "json") else {
            throw ResourcesError.fileNotFound(filename: filename)
        }
        return try Data(contentsOf: url)
    }
}
