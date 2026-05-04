//
//  TestData.swift
//  TheGoodCornerTests
//
//  Created by Sofienne Trimech on 04/05/2026.
//

import Foundation
@testable import TheGoodCorner

/// Centralized test fixtures for deterministic, server-independent tests.
enum TestData {

    // MARK: - Factories

    static func makeListing(
        id: Int = 1,
        categoryId: Int = 4,
        title: String = "Test Listing",
        description: String = "A test description",
        price: Double = 100.0,
        creationDate: Date = Date(timeIntervalSince1970: 1572969419), // 2019-11-05T15:56:59Z
        isUrgent: Bool = false,
        imagesURL: ImageURLs? = ImageURLs(small: "/images/ad-small/test.jpg", thumb: "/images/ad-thumb/test.jpg")
    ) -> Listing {
        Listing(
            id: id,
            categoryId: categoryId,
            title: title,
            description: description,
            price: price,
            creationDate: creationDate,
            isUrgent: isUrgent,
            imagesURL: imagesURL
        )
    }

    static func makeCategory(id: Int = 1, name: String = "Maison") -> TheGoodCorner.Category {
        TheGoodCorner.Category(id: id, name: name)
    }

    static func makeFeed(
        items: [Listing] = [],
        total: Int? = nil,
        page: Int = 1,
        hasMore: Bool = false
    ) -> ListingFeed {
        ListingFeed(
            total: total ?? items.count,
            page: page,
            limit: items.count,
            hasMore: hasMore,
            items: items
        )
    }

    // MARK: - JSON Fixtures

    static let validListingJSON = """
    {
        "id": 1461267313,
        "category_id": 4,
        "title": "Statue homme noir assis en plâtre polychrome",
        "description": "Magnifique statuette en terre cuite.",
        "price": 140.0,
        "creation_date": "2019-11-05T15:56:59Z",
        "is_urgent": false,
        "images_url": {
            "small": "/images/ad-small/test.jpg",
            "thumb": "/images/ad-thumb/test.jpg"
        }
    }
    """.data(using: .utf8)!

    static let listingWithNullImagesObjectJSON = """
    {
        "id": 2,
        "category_id": 8,
        "title": "PC portable",
        "description": "Un ordinateur.",
        "price": 199.0,
        "creation_date": "2019-10-16T17:10:20Z",
        "is_urgent": false,
        "images_url": null
    }
    """.data(using: .utf8)!

    static let listingWithNullImageFieldsJSON = """
    {
        "id": 3,
        "category_id": 5,
        "title": "LEGO Train",
        "description": "Pièces détachées.",
        "price": 37.0,
        "creation_date": "2019-11-05T15:56:45Z",
        "is_urgent": false,
        "images_url": {
            "small": null,
            "thumb": null
        }
    }
    """.data(using: .utf8)!

    /// Contains a `siret` field not documented in the swagger.
    /// The decoder must ignore unknown fields without crashing.
    static let listingWithUnknownFieldJSON = """
    {
        "id": 4,
        "category_id": 9,
        "title": "Professeur d'espagnol",
        "description": "Cours à domicile.",
        "price": 25.0,
        "creation_date": "2019-11-05T15:56:55Z",
        "is_urgent": false,
        "images_url": {
            "small": "/images/ad-small/test.jpg",
            "thumb": "/images/ad-thumb/test.jpg"
        },
        "siret": "123 323 002"
    }
    """.data(using: .utf8)!
}
