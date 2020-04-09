<p align="center">
  <img src="assets/logo.svg" alt="MeiliSearch-Swift" width="200" height="200" />
</p>

<h1 align="center">MeiliSearch-Swift</h1>

<h4 align="center">
  <a href="https://github.com/meilisearch/MeiliSearch">MeiliSearch</a> | 
  <a href="https://www.meilisearch.com">Website</a> | 
  <a href="https://blog.meilisearch.com">Blog</a> | 
  <a href="https://fr.linkedin.com/company/meilisearch">LinkedIn</a> | 
  <a href="https://twitter.com/meilisearch">Twitter</a> | 
  <a href="https://docs.meilisearch.com">Documentation</a> | 
  <a href="https://docs.meilisearch.com/resources/faq.html">FAQ</a>
</h4>

<p align="center">
  <a href="https://github.com/ppamorim/meilisearch-swift/actions"><img src="https://github.com/ppamorim/meilisearch-swift/workflows/Swift/badge.svg" alt="Build Status"></a>
  <a href="https://github.com/ppamorim/meilisearch-swift/blob/master/LICENSE"><img src="https://img.shields.io/badge/license-MIT-informational" alt="License"></a>
  <a href="https://slack.meilisearch.com"><img src="https://img.shields.io/badge/slack-MeiliSearch-blue.svg?logo=slack" alt="Slack"></a>
</p>

<p align="center">⚡ Lightning Fast, Ultra Relevant, and Typo-Tolerant Search Engine MeiliSearch client written in Swift 🍎</p>

**MeiliSearch-Swift** is a client for **MeiliSearch** written in Swift. **MeiliSearch** is a powerful, fast, open-source, easy to use and deploy search engine. Both searching and indexing are highly customizable. Features such as typo-tolerance, filters, and synonyms are provided out-of-the-box.
For more information about features go to [our Swift documentation](https://docs.meilisearch.com/swift).

## Features
* Search as-you-type experience (answers < 50 milliseconds)
* Full-text search
* Typo tolerant (understands typos and miss-spelling)
* Supports Kanji
* Supports Synonym
* Easy to install, deploy, and maintain
* Whole documents are returned
* Highly customizable
* RESTful API

## Get started

### Swift Package Manager

The [Swift Package Manager](https://swift.org/package-manager/) is a tool for automating the distribution of Swift code and is integrated into the `swift` compiler.

Once you have your Swift package set up, adding **MeiliSearch-Swift** as a dependency is as easy as adding it to the `dependencies` value of your `Package.swift`.

```swift
dependencies: [
    .package(url: "https://github.com/ppamorim/meilisearch-swift.git")
]
```

## Basic setup

To do a simply search using the client, you can create a Swift script like this:

```swift
import MeiliSearch

func searchForMovies() {

    // Create a new client instance of MeiliSearch with the default host.
    let client = try! MeiliSearch()

    // Create a new search request with "botman" as query.
    let searchParameters = SearchParameters.query("botman")

    // Call the function search and wait for the closure result.
    self.client.search(UID: "movies", searchParameters) { result in
        switch result {
        case .success(let searchResult):
            print(searchResult)
        case .failure(let error):
            print(error)
        }
    }

}
```

## Functions

The current functions implemented are:

### Index

| Swift function  | Similar to API call |
| ------------- | ------------- |
| `createIndex(UID:_)`  | `POST - /indexes`  |
| `getIndex(UID:_)`  | `GET - /indexes/:index_uid`  |
| `getIndexes(:_)`  | `GET - /indexes`  |
| `updateIndex(UID:_)`  | `POST - /indexes/:index_uid`  |
| `deleteIndex(UID:_)`  | `DELETE - /indexes/:index_uid`  |

### Documents

| Swift function  | Similar to API call |
| ------------- | ------------- |
| `addOrReplaceDocument(UID:document:primaryKey:_)`  | `POST - /indexes/:index_uid/documents`  |
| `addOrUpdateDocument(UID:document:primaryKey:_)`  | `PUT - /indexes/:index_uid/documents`  |
| `getDocument(UID:identifier:_)`  | `GET - /indexes/:index_uid/documents/:document_id`  |
| `getDocuments(UID:limit:_)`  | `GET - /indexes/:index_uid/documents`  |
| `deleteDocument(UID:identifier:_)`  | `DELETE - /indexes/:index_uid/documents/:document_id`  |
| `deleteAllDocuments(UID:_)`  | `DELETE - /indexes/:index_uid/documents`  |
| `deleteBatchDocuments(UID:documentsUID:_)`  | `POST - /indexes/:index_uid/documents/delete-batch`  |

### Search

| Swift function  | Similar to API call |
| ------------- | ------------- |
| `search(UID:_:_)`  | `GET - /indexes/:index_uid/search`  |

### Updates

| Swift function  | Similar to API call |
| ------------- | ------------- |
| `getUpdate(UID:_:_)`  | `GET - /indexes/:index_uid/updates/:updateId`  |
| `getAllUpdates(UID:_)`  | `GET - /indexes/:index_uid/updates`  |

### Keys

| Swift function  | Similar to API call |
| ------------- | ------------- |
| `keys(masterKey:_)`  | `GET - /keys`  |
| `getAllUpdates(UID:_)`  | `GET - /indexes/:index_uid/updates`  |

### Settings

Has to document, all implemented :)

### Stats

| Swift function  | Similar to API call |
| ------------- | ------------- |
| `stat(UID:_)`  | `GET - /indexes/:index_uid/stats`  |
| `allStats(:_)`  | `GET - /stats`  |

### Health

| Swift function  | Similar to API call |
| ------------- | ------------- |
| `health(UID:_)`  | `GET - /health`  |
| Not implemented | `PUT - /health`  |

### Version

| Swift function  | Similar to API call |
| ------------- | ------------- |
| `version(:_)`  | `GET - /version`  |

### System information

| Swift function  | Similar to API call |
| ------------- | ------------- |
| Not implemented | `GET - /sys-info/pretty`  |
| `systemInfo(:_)`  | `GET - /sys-info`  |

## Demo

### Vapor

Please check the Vapor Demo source code [here](https://github.com/ppamorim/meilisearch-swift/tree/master/VaporDemo).

## Contributing

Hey! We're glad you're thinking about contributing to **MeiliSearch-Swift**! If you think something is missing or could be improved, please open issues and pull requests. If you'd like to help this project grow, we'd love to have you! To start contributing, checking [issues tagged as "good-first-issue"](https://github.com/meilisearch/MeiliSearch-Swift/issues?q=is%3Aissue+is%3Aopen+label%3A%22good+first+issue%22) is a good start!

### Analytic Events

Once a day, events are being sent to our Amplitude instance so we can know how many people are using MeiliSearch.<br/>
Only information about the platform on which the server runs is stored. No other information is being sent.<br/>
If this doesn't suit you, you can disable these analytics by using the `MEILI_NO_ANALYTICS` env variable.

## Contact

Feel free to contact us about any questions you may have:
* At [bonjour@meilisearch.com](mailto:bonjour@meilisearch.com): English or French is welcome! 🇬🇧 🇫🇷
* Via the chat box available on every page of [our documentation](https://docs.meilisearch.com/) and on [our landing page](https://www.meilisearch.com/).
* Join our [Slack community](https://slack.meilisearch.com/).
* By opening an issue.

Any suggestion or feedback is highly appreciated. Thank you for your support!

Swift programming language from Apple
