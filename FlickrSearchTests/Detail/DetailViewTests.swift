import XCTest
import ViewInspector

@testable import FlickrSearch

@MainActor
class DetailViewTests: XCTestCase {
    var viewModel: MockViewModel<DetailAction, DetailState>!
    var subject: DetailView!

    override func setUp() {
        super.setUp()
        viewModel = MockViewModel(state: DetailState(imageResult: .fixture))
        subject = DetailView(viewModel: viewModel)
    }

    override func tearDown() {
        super.tearDown()
        viewModel = nil
        subject = nil
    }

    func test_dismissButton_tap() throws {
        let button = try subject.inspect().find(button: "Dismiss")
        try button.tap()

        XCTAssertEqual(viewModel.actions.last, .dismissPressed)
    }

    func test_showAllTagsButton_tap() throws {
        let button = try subject.inspect().find(button: "Show all")
        try button.tap()

        XCTAssertEqual(viewModel.actions.last, .showAllTagsPressed)
    }

    func test_tagButton_tap() throws {
        let button = try subject.inspect().find(button: "porcupine")
        try button.tap()

        XCTAssertEqual(viewModel.actions.last, .tagPressed("porcupine"))
    }
}
