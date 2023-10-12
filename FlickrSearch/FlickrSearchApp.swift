import SwiftUI

@main
struct FlickrSearchApp: App {
    var searchService = DefaultSearchService(
        apiService: APIService(
            baseURL: URL(string: "https://api.flickr.com/services/feeds/photos_public.gne")!,
            client: URLSession.shared
        )
    )

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                SearchView(
                    viewModel: SearchViewModel(
                        service: searchService,
                        state: SearchState()
                    )
                )
            }
        }
    }
}
