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
            LazyVGrid(
                columns: [
                    GridItem(.adaptive(minimum: 150, maximum: .infinity)),
                ],
                spacing: 16
            ) {
                ForEach(viewModel.state.results) { image in
                    Button {
                        print("button pressed: \(image.link)")
                    } label: {
                        AsyncImage(url: image.mediaLink) { image in
                            image
                                .resizable()
                                .scaledToFill()
                        } placeholder: {
                            Color.gray
                        }
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                        .aspectRatio(1, contentMode: .fill)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                }
            }
            .padding(16)
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
