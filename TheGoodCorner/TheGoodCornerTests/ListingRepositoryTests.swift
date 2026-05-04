//
//  ListingRepositoryTests.swift
//  TheGoodCornerTests
//
//  Created by Sofienne Trimech on 04/05/2026.
//

import XCTest
@testable import TheGoodCorner

final class ListingRepositoryTests: XCTestCase {

    // MARK: - Properties

    private var mockClient: MockAPIClient!
    private var repository: ListingRepository!

    // MARK: - Setup

    override func setUp() {
        super.setUp()
        mockClient = MockAPIClient()
        repository = ListingRepository(client: mockClient)
    }

    override func tearDown() {
        mockClient = nil
        repository = nil
        super.tearDown()
    }

    // MARK: - Tests

    /// Verifies that `fetchAllListings()` delegates to the `.allListings` endpoint.
    func test_fetchAllListings_callsCorrectEndpoint() async throws {
        let expectedFeed = TestData.makeFeed(items: [TestData.makeListing()])
        mockClient.stubbedResult = expectedFeed

        let result = try await repository.fetchAllListings()

        XCTAssertEqual(mockClient.lastEndpointCalled, .allListings)
        XCTAssertEqual(result.items.count, 1)
    }

    /// Verifies that errors from the API client propagate through the repository.
    func test_fetchAllListings_propagatesError() async {
        mockClient.stubbedError = HTTPError.networkError("timeout")

        do {
            _ = try await repository.fetchAllListings()
            XCTFail("Expected error to be thrown")
        } catch {
            XCTAssertEqual(error as? HTTPError, HTTPError.networkError("timeout"))
        }
    }
}
