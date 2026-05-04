//
//  ListingDecodingTests.swift
//  TheGoodCornerTests
//
//  Created by Sofienne Trimech on 04/05/2026.
//

import XCTest
@testable import TheGoodCorner

final class ListingDecodingTests: XCTestCase {

    // MARK: - Properties

    private var decoder: JSONDecoder!

    // MARK: - Setup

    override func setUp() {
        super.setUp()
        decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
    }

    override func tearDown() {
        decoder = nil
        super.tearDown()
    }

    // MARK: - Tests

    /// Verifies that all snake_case JSON fields are correctly mapped
    /// to camelCase Swift properties, including ISO 8601 date parsing.
    func test_decode_validJSON_mapsAllFields() throws {
        let listing = try decoder.decode(Listing.self, from: TestData.validListingJSON)

        XCTAssertEqual(listing.id, 1461267313)
        XCTAssertEqual(listing.categoryId, 4)
        XCTAssertEqual(listing.title, "Statue homme noir assis en plâtre polychrome")
        XCTAssertEqual(listing.price, 140.0)
        XCTAssertEqual(listing.isUrgent, false)
        XCTAssertNotNil(listing.imagesURL)
        XCTAssertEqual(listing.imagesURL?.small, "/images/ad-small/test.jpg")
        XCTAssertEqual(listing.imagesURL?.thumb, "/images/ad-thumb/test.jpg")

        // Verify ISO 8601 date parsing
        let components = Calendar(identifier: .gregorian)
            .dateComponents(in: TimeZone(identifier: "UTC")!, from: listing.creationDate)
        XCTAssertEqual(components.year, 2019)
        XCTAssertEqual(components.month, 11)
        XCTAssertEqual(components.day, 5)
    }

    /// The API schema marks `images_url` as `nullable: true`.
    /// When the entire object is null, `imagesURL` must be nil.
    func test_decode_nullImagesObject_setsNil() throws {
        let listing = try decoder.decode(Listing.self, from: TestData.listingWithNullImagesObjectJSON)

        XCTAssertNil(listing.imagesURL)
    }

    /// Even when the `images_url` object exists, both `small` and `thumb`
    /// can independently be null. The object should be present but with nil fields.
    func test_decode_nullImageFields_preservesObjectWithNilFields() throws {
        let listing = try decoder.decode(Listing.self, from: TestData.listingWithNullImageFieldsJSON)

        XCTAssertNotNil(listing.imagesURL, "images_url object should exist")
        XCTAssertNil(listing.imagesURL?.small)
        XCTAssertNil(listing.imagesURL?.thumb)
    }

    /// The seed data contains a `siret` field not present in the swagger schema.
    /// The decoder must silently ignore unknown fields.
    func test_decode_unknownField_siret_decodesSuccessfully() throws {
        let listing = try decoder.decode(Listing.self, from: TestData.listingWithUnknownFieldJSON)

        XCTAssertEqual(listing.id, 4)
        XCTAssertEqual(listing.title, "Professeur d'espagnol")
    }
}
