@testable import FlickrSearch

class MockViewModel<Action, State>: ViewModel<Action, State> {
    var actions: [Action] = []

    override func receive(_ action: Action) {
        actions.append(action)
    }
}

