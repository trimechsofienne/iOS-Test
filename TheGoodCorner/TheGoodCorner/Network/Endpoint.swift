//
//  Endpoint.swift
//  TheGoodCorner
//
//  Created by Sofienne Trimech on 04/05/2026.
//

import Foundation

/// Type-safe representation of all available API endpoints.
///
/// Each case encapsulates the path and query parameters needed
/// to build a `URLRequest`. The `APIClient` consumes this enum
/// internally — the repository layer never builds raw requests.
enum Endpoint: Equatable {

    /// `GET /listings` — returns all listings without pagination.
    case allListings

    /// `GET /listings?page=X&limit=Y` — paginated listings.
    case listings(page: Int, limit: Int)

    /// `GET /categories` — all listing categories.
    case categories

    /// `GET /listings?query=X` — search by title and description.
    case search(query: String)

    // MARK: - URL Construction

    func urlRequest(baseURL: URL) -> URLRequest? {
        var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: false)

        switch self {
        case .allListings:
            components?.path = "/listings"

        case .listings(let page, let limit):
            components?.path = "/listings"
            components?.queryItems = [
                URLQueryItem(name: "page", value: "\(page)"),
                URLQueryItem(name: "limit", value: "\(limit)")
            ]

        case .search(let query):
            components?.path = "/listings"
            components?.queryItems = [
                URLQueryItem(name: "query", value: query)
            ]

        case .categories:
            components?.path = "/categories"
        }

        guard let url = components?.url else { return nil }
        return URLRequest(url: url)
    }
}
