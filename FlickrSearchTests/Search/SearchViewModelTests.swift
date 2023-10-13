import XCTest

@testable import FlickrSearch

@MainActor
class SearchViewModelTests: XCTestCase {
    // MARK: Properties

    var service: MockSearchService!
    var subject: SearchViewModel!

    // MARK: Setup & Teardown

    override func setUp() {
        super.setUp()
        service = MockSearchService()
        subject = SearchViewModel(
            service: service,
            state: SearchState()
        )
    }

    override func tearDown() {
        super.tearDown()

        service = nil
        subject = nil
    }

    // MARK: Tests

    func test_receive_searchTextChanged_withValue() {
        subject.receive(.searchTextChanged("search"))

        XCTAssertEqual(subject.state.searchText, "search")
    }

    func test_receive_searchTextChanged_withoutValue() {
        subject.state.searchText = "search"
        subject.state.results = [.fixture]
        subject.receive(.searchTextChanged(""))

        XCTAssertEqual(service.retrieveImagesCount, 0)
        XCTAssertEqual(subject.state.results, [])
    }

    func test_receive_dismissDetail() {
        subject.state.imageResultPresentedInDetail = .fixture
        subject.receive(.dismissDetail)

        XCTAssertNil(subject.state.imageResultPresentedInDetail)
    }

    func test_receive_tagSelected() {
        subject.state.searchText = ""
        subject.state.imageResultPresentedInDetail = .fixture
        subject.receive(.tagSelected("tag"))

        XCTAssertEqual(subject.state.searchText, "tag")
        XCTAssertNil(subject.state.imageResultPresentedInDetail)
    }

    func test_receive_imagePressed() {
        subject.state.imageResultPresentedInDetail = nil
        subject.receive(.imagePressed(.fixture))

        XCTAssertEqual(subject.state.imageResultPresentedInDetail, .fixture)
    }
}
