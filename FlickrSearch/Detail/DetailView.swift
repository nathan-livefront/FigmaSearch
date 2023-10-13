import SwiftUI

// MARK: - DetailView

struct DetailView: View {
    // MARK: Properties

    /// The `ViewModel` for this view.
    @ObservedObject var viewModel: ViewModel<DetailAction, DetailState>

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                VStack(spacing: 2) {
                    AsyncImage(url: viewModel.state.imageResult.mediaLink) { image in
                        image
                            .resizable()
                            .scaledToFit()
                    } placeholder: {
                        Color.gray
                    }

                    HStack {
                        Spacer()
                        Text("\(viewModel.state.width) × \(viewModel.state.height)")
                            .font(.system(.caption))
                            .foregroundColor(.secondary)
                            .accessibilityLabel(Text("Dimensions: \(viewModel.state.width) by \(viewModel.state.height)"))
                    }
                    .padding(.trailing)
                }

                VStack(alignment: .leading, spacing: 16) {
                    Text(viewModel.state.imageResult.title)
                        .font(.system(.title, weight: .bold))

                    Text("Taken by: ")
                        .bold()
                    + Text(viewModel.state.imageResult.author)

                    tagList
                }
                .padding(.horizontal)
            }
        }
        .navigationTitle("Detail")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem {
                Button {
                    viewModel.receive(.dismissPressed)
                } label: {
                    Label("Dismiss", systemImage: "xmark")
                }
            }
        }
    }

    /// A view of the list of tags.
    @ViewBuilder private var tagList: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Tags")
                .font(.system(.headline))

            if viewModel.state.areAllTagsDisplayed {
                ForEach(viewModel.state.imageResult.tags, id: \.self) { tagName in
                    tag(tagName)
                }
            } else {
                ForEach(viewModel.state.imageResult.tags.prefix(5), id: \.self) { tagName in
                    tag(tagName)
                }
                if viewModel.state.imageResult.tags.count > 5 {
                    Button("Show all") {
                        viewModel.receive(.showAllTagsPressed)
                    }
                    .accessibilityLabel("Show all tags")
                }
            }
        }
    }

    // MARK: Methods

    /// Creates a view of a single tag.
    ///
    /// - Parameter tagValue: The value of the tag.
    ///
    @ViewBuilder private func tag(_ tagValue: String) -> some View {
        Button {
            viewModel.receive(.tagPressed(tagValue))
        } label: {
            HStack {
                Image(systemName: "tag.fill")
                    .font(.system(.caption))
                Text(tagValue)
                    .font(.system(.callout))
            }
            .foregroundColor(.white)
            .padding(4)
            .background(Color.gray.opacity(0.75))
            .clipShape(RoundedRectangle(cornerRadius: 4))
            .accessibilityLabel(Text("\(tagValue) tag"))
        }
        .accessibilityHint(Text("search for tag"))
    }
}

// MARK: Previews

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(
            viewModel: ViewModel(
                state: DetailState(imageResult: .fixture)
            )
        )
    }
}
