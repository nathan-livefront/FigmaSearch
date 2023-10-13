import Foundation

// MARK: - DetailState

/// An object representing the information displayed in `DetailView`.
struct DetailState: Equatable {
    /// A flag indicating if all the tags are being displayed or not.
    var areAllTagsDisplayed = false

    /// The full image result for the image being displayed.
    var imageResult: ImageResult

    /// The width of the image.
    var width: Int

    /// The height of the image.
    var height: Int
}

extension DetailState {
    /// Creates a `DetailState`.
    ///
    /// - Parameter imageResult: The full image result to use to create this state.
    ///
    init(imageResult: ImageResult) {
        self.areAllTagsDisplayed = false
        self.imageResult = imageResult

        let regex = /width=\"(?<width>\d+)\".*height=\"(?<height>\d+)\"/
        if let match = imageResult.description.firstMatch(of: regex),
           let width = Int(match.output.width),
           let height = Int(match.output.height) {
            self.width = width
            self.height = height
        } else {
            self.width = 0
            self.height = 0
        }
    }
}
