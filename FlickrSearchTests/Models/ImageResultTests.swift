import XCTest

@testable import FlickrSearch

// MARK: - ImageResultTests

class ImageResultTests: XCTestCase {
    func test_decode_success() throws {
        let json = try Resources.imageResultSuccess
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601
        let subject = try decoder.decode(ImageResult.self, from: json)

        XCTAssertEqual(subject.title, "DSCF0693")
        XCTAssertEqual(subject.link, URL(string: "https://www.flickr.com/photos/kilowattusaf/53250196148/"))
        XCTAssertEqual(subject.media, [
            "m": "https://live.staticflickr.com/65535/53250196148_ee45194b42_m.jpg"
        ])
        XCTAssertEqual(subject.dateTaken, try Date("2023-10-08T08:42:00-08:00", strategy: .iso8601))
        XCTAssertEqual(subject.description, """
         <p><a href=\"https://www.flickr.com/people/kilowattusaf/\">kwattalive</a> posted a photo:</p> <p><a href=\"https://www.flickr.com/photos/kilowattusaf/53250196148/\" title=\"DSCF0693\"><img src=\"https://live.staticflickr.com/65535/53250196148_ee45194b42_m.jpg\" width=\"240\" height=\"160\" alt=\"DSCF0693\" /></a></p> <p>Turnbull Wildlife Refuge Cheney, WA</p>
        """)
        XCTAssertEqual(subject.published, try Date("2023-10-11T04:10:29Z", strategy: .iso8601))
        XCTAssertEqual(subject.author, "kwattalive")
        XCTAssertEqual(subject.authorEmail, "nobody@flickr.com")
        XCTAssertEqual(subject.authorId, "198785474@N03")
        XCTAssertEqual(subject.tags, [
            "turnbullwildliferefuge",
            "turnbull",
            "friendsofturnbull",
            "twr",
            "porcupine",
        ])
    }
}
