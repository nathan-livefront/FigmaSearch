# Flickr Search

Flickr Search is a simple application for searching for tags on Flickr.

## Contents

- [Compatibility](#compatibility)
- [Demo](#demo)
- [Setup](#setup)
- [Todo](#todo)

## Compatibility

- **Minimum iOS**: `16.4`
- **Target SDK**: `16.4`
- **Device Types Supported**: iPhone
- **Screen Sizes Supported**: iPhone SE to iPhone 14 Pro Max
- **Orientations Supported**: Portrait, Landscape
- **Minimum Xcode**: `14.3`

## Demo

![Demo](demo.gif)

## Setup

1. Clone the repository:

    ```sh
    $ git clone https://github.com/nathan-livefront/FlickrSearch.git
    ```

### Run the App

1. Open the project in Xcode 14.3+.
2. Run the app in the Simulator with the `FlickrSearch` target.

### Running Tests

1. In Xcode's toolbar, select the `FlickrSearch` target and a Simulator destination.
   - The `Generic iOS Device` destination used for builds will not work for testing.

1. In Xcode's menu bar, select `Product > Test`.
   - Test results appear in the Debug Area, which can be accessed from `View > Debug Area > Show Debug Area` if not already visible.
   - Test coverage information also appear in the Debug Area, listed within the test results as `Coverage`.

## Todo

If I had more time to work on this project, I would like to add:
- [ ] More unit tests, to bring the total test coverage of the project above 90%.
- [ ] Snapshot tests, using the [SnapshotTesting](https://github.com/pointfreeco/swift-snapshot-testing) framework.
- [ ] Fully document all the objects used with networking, e.g. `HTTPRequest`, `HTTPResponse`, `Response`.
- [ ] Better support for the `Increased Contrast` accessibility setting, especially for the titles displayed in the `SearchView`.
- [ ] Animated transitions to and from the `DetailView`.
- [ ] A share button in the `DetailView` for sharing a link to the image being viewed.
- [ ] A button in the `DetailView` to open the image on the Flickr website.
- [ ] More debug logging.
  - The networking logic would benefit from more robust logging, as would `ViewModel`.
