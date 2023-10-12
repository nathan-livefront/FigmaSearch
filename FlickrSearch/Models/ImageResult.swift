import Foundation

// MARK: - ImageResult

/// An individual image result from a search request.
///
struct ImageResult: Codable {
    // MARK: Types

    /// The coding keys for `ImageResult`. Needs to be explicitly defined since we are performing custom decoding and
    /// encoding.
    enum CodingKeys: CodingKey {
        case title
        case link
        case media
        case dateTaken
        case description
        case published
        case author
        case authorId
        case tags
    }

    // MARK: Properties

    /// The name or username of the author of this image.
    var author: String

    /// The email associated with the author of this image.
    var authorEmail: String

    /// The id for the author of this image.
    var authorId: String

    /// The date this image was taken.
    var dateTaken: Date

    /// A description for this image.
    var description: String

    /// A permalink to this image on Flickr.
    var link: URL

    /// The associated media for this image.
    var media: [String: String]

    /// The date this image was posted on Flickr.
    var published: Date

    /// The tags associated with this image.
    var tags: [String]

    /// The title of this image.
    var title: String
}

extension ImageResult {
    // MARK: Initialization

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try container.decode(String.self, forKey: .title)
        self.link = try container.decode(URL.self, forKey: .link)
        self.media = try container.decode([String : String].self, forKey: .media)
        self.dateTaken = try container.decode(Date.self, forKey: .dateTaken)
        self.description = try container.decode(String.self, forKey: .description)
        self.published = try container.decode(Date.self, forKey: .published)

        let rawAuthor = try container.decode(String.self, forKey: .author)
        let authorRegex = /(?<email>\S+@\S+.\S+) .*(?:\")(?<name>.+)(?:\")/
        let matches = rawAuthor.firstMatch(of: authorRegex)?.output
        self.author = String(matches?.name ?? "")
        self.authorEmail = String(matches?.email ?? "")

        self.authorId = try container.decode(String.self, forKey: .authorId)
        self.tags = (try container.decode(String.self, forKey: .tags)).components(separatedBy: .whitespaces)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.title, forKey: .title)
        try container.encode(self.link, forKey: .link)
        try container.encode(self.media, forKey: .media)
        try container.encode(self.dateTaken, forKey: .dateTaken)
        try container.encode(self.description, forKey: .description)
        try container.encode(self.published, forKey: .published)
        try container.encode("\(self.authorEmail) (\\\"\(self.author)\\\")", forKey: .author)
        try container.encode(self.authorId, forKey: .authorId)
        try container.encode(self.tags.joined(separator: " "), forKey: .tags)
    }
}
