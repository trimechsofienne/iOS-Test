//
//  ListingRepository.swift
//  TheGoodCorner
//
//  Created by Sofienne Trimech on 04/05/2026.
//

import Foundation

/// Concrete implementation of `ListingRepositoryProtocol`.
///
/// Delegates all network calls to `APIClientProtocol`.
/// The repository never constructs URLs or accesses `baseURL` —
/// it simply maps domain operations to typed endpoints.
final class ListingRepository: ListingRepositoryProtocol {

    // MARK: - Properties

    private let client: APIClientProtocol

    // MARK: - Init

    init(client: APIClientProtocol) {
        self.client = client
    }

    // MARK: - ListingRepositoryProtocol

    func fetchAllListings() async throws -> ListingFeed {
        try await client.fetch(.allListings)
    }

    func fetchListings(page: Int, limit: Int) async throws -> ListingFeed {
        try await client.fetch(.listings(page: page, limit: limit))
    }

    func fetchCategories() async throws -> [Category] {
        try await client.fetch(.categories)
    }

    func searchListings(query: String) async throws -> ListingFeed {
        try await client.fetch(.search(query: query))
    }
}
