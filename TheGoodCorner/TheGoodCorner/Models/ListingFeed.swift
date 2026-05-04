//
//  ListingFeed.swift
//  TheGoodCorner
//
//  Created by Sofienne Trimech on 04/05/2026.
//

import Foundation

/// API feed envelope returned by `GET /listings`.
struct ListingFeed: Decodable, Equatable, Sendable {

    // MARK: - Properties

    let total: Int
    let page: Int
    let limit: Int
    let hasMore: Bool
    let items: [Listing]

    // MARK: - CodingKeys

    enum CodingKeys: String, CodingKey {
        case total
        case page
        case limit
        case hasMore = "has_more"
        case items
    }
}
