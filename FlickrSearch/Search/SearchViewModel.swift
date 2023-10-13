import Combine
import Foundation

// MARK: - SearchViewModel

/// A view model that can handle `SearchAction`s.
///
class SearchViewModel: ViewModel<SearchAction, SearchState> {
    var service: SearchService

    private var currentSearchingTask: Task<(), Never>?

    init(service: SearchService, state: SearchState) {
        self.service = service
        super.init(state: state)
    }

    // MARK: Methods

    override func receive(_ action: SearchAction) {
        switch action {
        case .dismissDetail:
            state.imageResultPresentedInDetail = nil
        case let .imagePressed(newValue):
            state.imageResultPresentedInDetail = newValue
        case let .searchTextChanged(newValue):
            state.searchText = newValue
            performSearch(with: newValue)
        case let .tagSelected(newValue):
            state.imageResultPresentedInDetail = nil
            state.searchText = newValue
            performSearch(with: newValue)
        }
    }

    // MARK: Private Methods

    private func performSearch(with searchText: String) {
        guard !searchText.isEmpty else {
            state.results = []
            return
        }

        print("Searching for: \(searchText)")
        if let currentSearchingTask {
            currentSearchingTask.cancel()
        }
        currentSearchingTask = Task {
            let tags = searchText
                .replacingOccurrences(of: ", ", with: ",")
                .replacingOccurrences(of: " ", with: ",")
                .components(separatedBy: ",")
            do {
                let response = try await service.retrieveImages(for: tags)
                state.results = response.items
            } catch {
                print(error)
                // TODO: Present an alert when there is a network error
            }

            self.currentSearchingTask = nil
        }
    }
}
