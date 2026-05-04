//
//  EndpointTests.swift
//  TheGoodCornerTests
//
//  Created by Sofienne Trimech on 04/05/2026.
//

import XCTest
@testable import TheGoodCorner

final class EndpointTests: XCTestCase {

    // MARK: - Properties

    private let baseURL = URL(string: "http://localhost:8080")!

    // MARK: - Tests

    /// `.allListings` must produce `/listings` with no query parameters.
    func test_allListings_hasNoQueryParams() {
        let request = Endpoint.allListings.urlRequest(baseURL: baseURL)

        XCTAssertNotNil(request)
        XCTAssertEqual(request?.url?.path, "/listings")
        XCTAssertNil(request?.url?.query, "allListings should have no query parameters")
    }

    /// `.listings(page:limit:)` must include both pagination parameters.
    func test_paginatedListings_includesPageAndLimit() {
        let request = Endpoint.listings(page: 2, limit: 10).urlRequest(baseURL: baseURL)

        XCTAssertNotNil(request)
        let components = URLComponents(url: request!.url!, resolvingAgainstBaseURL: false)
        let queryItems = components?.queryItems ?? []

        XCTAssertTrue(queryItems.contains(URLQueryItem(name: "page", value: "2")))
        XCTAssertTrue(queryItems.contains(URLQueryItem(name: "limit", value: "10")))
    }

    /// `.search(query:)` must encode the search term as a query parameter.
    func test_search_encodesQueryParam() {
        let request = Endpoint.search(query: "table bois").urlRequest(baseURL: baseURL)

        XCTAssertNotNil(request)
        XCTAssertEqual(request?.url?.path, "/listings")

        let components = URLComponents(url: request!.url!, resolvingAgainstBaseURL: false)
        let queryItems = components?.queryItems ?? []

        XCTAssertTrue(queryItems.contains(URLQueryItem(name: "query", value: "table bois")))
    }

    /// `.categories` must hit the `/categories` path with no query parameters.
    func test_categories_hasCorrectPath() {
        let request = Endpoint.categories.urlRequest(baseURL: baseURL)

        XCTAssertNotNil(request)
        XCTAssertEqual(request?.url?.path, "/categories")
        XCTAssertNil(request?.url?.query)
    }
}
