# MCFeed

Simple, scrollable feed-like interface that displays articles from raw JSON data.

## App Architecture

### UI

MCFeedTableViewController: Shows a list of articles using MVVM pattern.

MCArticleCell: Article cell. Shows Image, Date, Title and Summary.

MCArticleViewModel: Article cell view model.

Custom Transition: I have reused a custom transition between MCFeedTableViewController and MCArticleDetailViewController (TransitioningDelegate, PresentationAnimator, DismissalAnimator).

MCArticleDetailViewController: shows all article properties with a button to open original article in browser.

UIColor+Hex: UIColor extension to set color with hexa string.

### Model

Model: MCArticle, MCTopic, MCMedia, MCAttribution.

### Domain

Domain: MCFeedDomain (protocol), MCFeed (implementation), MCFeedRepository (protocol).

### Repository

Repository: MCFeedDataRepository (implementation), MCFeedAPIService (API requests), MCFeedCacheService (simple persistence class).

## Installation

1. Clone project
2. Open Terminal and navigate to the directory that contains the project.
2. Run: pod install
3. Open MCFeed.xcworkspace

## Requirements

Xcode 8.2.1+
iOS 10.0+

## Contact

[Matias Roldan](mailto:roldanmatias@gmail.com)

## License

Copyright 2017 Matias Roldan
No commercial usage is permitted.
