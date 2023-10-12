import SwiftUI

// MARK: - SearchView

/// A view that displays a search bar and the results of performing an image search.
///
struct SearchView: View {
    // MARK: Properties

    /// The `ViewModel` for this view.
    @ObservedObject var viewModel: ViewModel<SearchAction, SearchState>

    var body: some View {
        ScrollView {
            LazyVGrid(columns: [
                GridItem(.flexible()),
                GridItem(.flexible()),
            ]) {
                ForEach(viewModel.state.results) { image in
                    Button {
                        print("button pressed: \(image.link)")
                    } label: {
                        Text(image.title)
                            .foregroundColor(.white)
                            .aspectRatio(contentMode: .fill)
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                            .aspectRatio(contentMode: .fit)
                            .background(Color.gray)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                }
            }
            .padding()
        }
        .searchable(
            text: viewModel.binding(
                get: \.searchText,
                set: SearchAction.searchTextChanged
            ),
            placement: .navigationBarDrawer(displayMode: .always),
            prompt: "porcupine"
        )
        .background(Color(.systemGroupedBackground).ignoresSafeArea())
        .navigationTitle("Search")
        .navigationBarTitleDisplayMode(.large)
    }
}

// MARK: Previews

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SearchView(
                viewModel: ViewModel(
                    state: SearchState()
                )
            )
        }
        .previewDisplayName("Empty")

        NavigationView {
            SearchView(
                viewModel: ViewModel(
                    state: SearchState(
                        searchText: "porcupine",
                        results: [.fixture]
                    )
                )
            )
        }
        .previewDisplayName("1 Result")
    }
}
