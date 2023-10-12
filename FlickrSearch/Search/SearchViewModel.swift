import Foundation

// MARK: - SearchViewModel

/// A view model that can handle `SearchAction`s.
///
class SearchViewModel: ViewModel<SearchAction, SearchState> {
    var service: SearchService

    init(service: SearchService, state: SearchState) {
        self.service = service
        super.init(state: state)
    }

    // MARK: Methods

    override func receive(_ action: SearchAction) {
        switch action {
        case let .searchTextChanged(newValue):
            state.searchText = newValue
            performSearch(with: newValue)
        }
    }

    // MARK: Private Methods

    private func performSearch(with searchText: String) {
        Task {
            let tags = searchText
                .replacingOccurrences(of: ", ", with: ",")
                .components(separatedBy: ",")
            do {
                let response = try await service.retrieveImages(for: tags)
                state.results = response.items
            } catch {
                print(error)
            }
        }
    }
}
