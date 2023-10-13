import XCTest

@testable import FlickrSearch

@MainActor
class DetailViewModelTests: XCTestCase {
    var subject: DetailViewModel!

    override func setUp() {
        super.setUp()
        subject = DetailViewModel(
            state: DetailState(
                imageResult: .fixture
            )
        )
    }

    override func tearDown() {
        super.tearDown()
        subject = nil
    }

    // MARK: Tests

    func test_receive_dismissPressed() {
        var onDismissCalled = false
        subject.onDismiss = {
            onDismissCalled = true
        }
        subject.receive(.dismissPressed)

        XCTAssertTrue(onDismissCalled)
    }

    func test_receive_tagPressed() {
        var tagPressed: String? = nil
        subject.onTagPressed = { tag in
            tagPressed = tag
        }
        subject.receive(.tagPressed("tag"))

        XCTAssertEqual(tagPressed, "tag")
    }

    func test_receive_showAllTagsPressed() {
        subject.state.areAllTagsDisplayed = false
        subject.receive(.showAllTagsPressed)

        XCTAssertTrue(subject.state.areAllTagsDisplayed)
    }
}
