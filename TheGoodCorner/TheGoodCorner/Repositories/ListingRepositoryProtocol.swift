//
//  ListingRepositoryProtocol.swift
//  TheGoodCorner
//
//  Created by Sofienne Trimech on 04/05/2026.
//

import Foundation

/// Abstraction for data access.
///
/// Separated from the implementation to allow swapping the data source
/// (e.g., adding a caching layer) without modifying the ViewModel.
protocol ListingRepositoryProtocol: Sendable {

    /// Fetches all listings without pagination.
    func fetchAllListings() async throws -> ListingFeed

    /// Fetches a paginated page of listings.
    func fetchListings(page: Int, limit: Int) async throws -> ListingFeed

    /// Fetches all available categories.
    func fetchCategories() async throws -> [Category]

    /// Searches listings by title and description.
    func searchListings(query: String) async throws -> ListingFeed
}
