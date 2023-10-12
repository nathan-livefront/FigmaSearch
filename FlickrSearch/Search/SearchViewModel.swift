import Foundation

// MARK: - SearchViewModel

/// A view model that can handle `SearchAction`s.
///
class SearchViewModel: ViewModel<SearchAction, SearchState> {
    override func receive(_ action: SearchAction) {
        switch action {
        case let .searchTextChanged(newValue):
            state.searchText = newValue
        }
    }
}
