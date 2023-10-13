import XCTest
import ViewInspector

@testable import FlickrSearch

@MainActor
class SearchViewTests: XCTestCase {
    var viewModel: MockViewModel<SearchAction, SearchState>!
    var subject: SearchView!

    override func setUp() {
        super.setUp()
        viewModel = MockViewModel(state: SearchState())
        subject = SearchView(viewModel: viewModel)
    }

    override func tearDown() {
        super.tearDown()
        viewModel = nil
        subject = nil
    }

    func test_imagePressed() throws {
        viewModel.state.results = [.fixture]
        let button = try subject.inspect().find(ViewType.Button.self) { view in
            try view.id() == (ImageResult.fixture.id as AnyHashable)
        }
        try button.tap()

        XCTAssertEqual(viewModel.actions.last, .imagePressed(.fixture))
    }
}
