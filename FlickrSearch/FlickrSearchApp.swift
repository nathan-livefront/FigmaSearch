import SwiftUI

@main
struct FlickrSearchApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                SearchView(
                    viewModel: SearchViewModel(
                        state: SearchState()
                    )
                )
            }
        }
    }
}
