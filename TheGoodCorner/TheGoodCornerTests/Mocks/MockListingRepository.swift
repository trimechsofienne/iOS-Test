//
//  MockListingRepository.swift
//  TheGoodCornerTests
//
//  Created by Sofienne Trimech on 04/05/2026.
//

import Foundation
@testable import TheGoodCorner

/// Mock implementation of `ListingRepositoryProtocol` for ViewModel tests.
///
/// Each method's result is independently configurable via `Result` properties.
/// This allows testing success and failure paths without a network dependency.
final class MockListingRepository: ListingRepositoryProtocol, @unchecked Sendable {

    // MARK: - Stubs

    var fetchAllListingsResult: Result<ListingFeed, Error> = .failure(HTTPError.networkError("not configured"))
    var fetchListingsResult: Result<ListingFeed, Error> = .failure(HTTPError.networkError("not configured"))
    var fetchCategoriesResult: Result<[TheGoodCorner.Category], Error> = .failure(HTTPError.networkError("not configured"))
    var searchListingsResult: Result<ListingFeed, Error> = .failure(HTTPError.networkError("not configured"))

    // MARK: - Call Tracking

    private(set) var fetchAllListingsCallCount = 0
    private(set) var fetchListingsCallCount = 0
    private(set) var fetchCategoriesCallCount = 0
    private(set) var searchListingsCallCount = 0
    private(set) var lastFetchedPage: Int?
    private(set) var lastSearchQuery: String?

    // MARK: - ListingRepositoryProtocol

    func fetchAllListings() async throws -> ListingFeed {
        fetchAllListingsCallCount += 1
        return try fetchAllListingsResult.get()
    }

    func fetchListings(page: Int, limit: Int) async throws -> ListingFeed {
        fetchListingsCallCount += 1
        lastFetchedPage = page
        return try fetchListingsResult.get()
    }

    func fetchCategories() async throws -> [TheGoodCorner.Category] {
        fetchCategoriesCallCount += 1
        return try fetchCategoriesResult.get()
    }

    func searchListings(query: String) async throws -> ListingFeed {
        searchListingsCallCount += 1
        lastSearchQuery = query
        return try searchListingsResult.get()
    }
}
