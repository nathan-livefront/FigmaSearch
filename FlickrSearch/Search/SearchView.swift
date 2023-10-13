import SwiftUI

// MARK: - SearchView

/// A view that displays a search bar and the results of performing an image search.
///
struct SearchView: View {
    // MARK: Properties

    /// The `ViewModel` for this view.
    @ObservedObject var viewModel: ViewModel<SearchAction, SearchState>

    var body: some View {
        search
            .sheet(isPresented: viewModel.binding(
                get: \.isDetailPresented,
                set: { _ in .dismissDetail }
            )) {
                NavigationStack {
                    DetailView(
                        viewModel: DetailViewModel(
                            onDismiss: { viewModel.receive(.dismissDetail) },
                            onTagPressed: { viewModel.receive(.tagSelected($0)) },
                            state: DetailState(
                                imageResult: viewModel.state.imageResultPresentedInDetail!
                            )
                        )
                    )
                }
            }
            .navigationTitle("Flickr")
            .navigationBarTitleDisplayMode(.large)
    }

    /// The list of search results.
    @ViewBuilder var search: some View {
        ScrollView {
            LazyVGrid(
                columns: [
                    GridItem(.adaptive(minimum: 150, maximum: .infinity)),
                ],
                spacing: 16
            ) {
                ForEach(viewModel.state.results) { imageResult in
                    imageButton(for: imageResult)
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
            prompt: "Search"
        )
        .scrollDismissesKeyboard(.immediately)
        .background(Color(.systemGroupedBackground).ignoresSafeArea())
    }

    // MARK: Methods

    /// Crates an button that displays an image result within it. When pressed, the
    /// `.imagePressed` action is dispatched to the view model.
    ///
    /// - Parameter imageResult: The image result to display in this button.
    /// 
    @ViewBuilder private func imageButton(for imageResult: ImageResult) -> some View {
        Button {
            viewModel.receive(.imagePressed(imageResult))
        } label: {
            ZStack(alignment: .bottomLeading) {
                AsyncImage(url: imageResult.mediaLink) { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    Color.gray
                }
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                .aspectRatio(1, contentMode: .fill)

                HStack {
                    Text(imageResult.title)
                        .lineLimit(1)
                        .padding([.bottom, .leading], 4)
                        .padding(.top, 24)
                        .foregroundColor(.white)
                    Spacer()
                }
                .frame(minWidth: 0, maxWidth: .infinity)
                .background(LinearGradient(gradient: Gradient(colors: [.clear, .black.opacity(0.2), .black.opacity(0.6)]), startPoint: .top, endPoint: .bottom))
            }
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .accessibilityLabel(Text(imageResult.title))
        }
        .id(imageResult.id)
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

        NavigationView {
            SearchView(
                viewModel: ViewModel(
                    state: SearchState(
                        searchText: "porcupine",
                        results: [.fixture],
                        imageResultPresentedInDetail: .fixture
                    )
                )
            )
        }
        .previewDisplayName("Detail")
    }
}
