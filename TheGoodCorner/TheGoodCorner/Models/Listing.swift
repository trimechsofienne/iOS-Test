//
//  Listing.swift
//  TheGoodCorner
//
//  Created by Sofienne Trimech on 04/05/2026.
//

import Foundation

/// Core data model representing a classified ad.
nonisolated struct Listing: Identifiable, Decodable, Equatable, Hashable, Sendable {

    // MARK: - Properties

    let id: Int
    let categoryId: Int
    let title: String
    let description: String
    let price: Double
    let creationDate: Date
    let isUrgent: Bool
    let imagesURL: ImageURLs?

    // MARK: - CodingKeys

    enum CodingKeys: String, CodingKey {
        case id
        case categoryId = "category_id"
        case title
        case description
        case price
        case creationDate = "creation_date"
        case isUrgent = "is_urgent"
        case imagesURL = "images_url"
    }

    // MARK: - Hashable

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (lhs: Listing, rhs: Listing) -> Bool {
        lhs.id == rhs.id
    }
}
