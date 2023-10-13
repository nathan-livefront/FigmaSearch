import XCTest

@testable import FlickrSearch

class DetailStateTests: XCTestCase {
    func test_init_widthAndHeight() throws {
        let subject = DetailState(imageResult: .fixture)

        XCTAssertEqual(subject.width, 240)
        XCTAssertEqual(subject.height, 160)
    }
}
