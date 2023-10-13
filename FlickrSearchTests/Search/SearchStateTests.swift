import XCTest

@testable import FlickrSearch

class SearchStateTests: XCTestCase {
    func test_isDetailPresented() {
        var subject = SearchState()
        XCTAssertFalse(subject.isDetailPresented)

        subject.imageResultPresentedInDetail = .fixture
        XCTAssertTrue(subject.isDetailPresented)

        subject.imageResultPresentedInDetail = nil
        XCTAssertFalse(subject.isDetailPresented)
    }
}
