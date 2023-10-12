import SwiftUI

struct SearchView: View {
    @State var searchText: String = ""

    var body: some View {
        ScrollView {
            LazyVGrid(columns: [
                GridItem(.flexible()),
                GridItem(.flexible()),
            ]) {
                ForEach(0...10, id: \.self) { id in
                    Button {
                        print("button pressed: \(id)")
                    } label: {
                        Text("Hello World")
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
            text: $searchText,
            prompt: "porcupine"
        )
        .background(Color(.systemGroupedBackground).ignoresSafeArea())
        .navigationTitle("Search")
        .navigationBarTitleDisplayMode(.large)
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SearchView()
        }
        .previewDisplayName("Empty")
    }
}
