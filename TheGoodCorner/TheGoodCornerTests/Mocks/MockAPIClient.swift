//
//  MockAPIClient.swift
//  TheGoodCornerTests
//
//  Created by Sofienne Trimech on 04/05/2026.
//

import Foundation
@testable import TheGoodCorner

/// Mock implementation of `APIClientProtocol` for deterministic testing.
///
/// Allows stubbing responses and tracking which endpoint was called,
/// without requiring the local server to be running.
final class MockAPIClient: APIClientProtocol, @unchecked Sendable {

    // MARK: - Properties

    let baseURL = URL(string: "http://test.local")!

    /// The result to return from `fetch`. Set before calling the method under test.
    var stubbedResult: Any?

    /// The error to throw from `fetch`. Takes priority over `stubbedResult`.
    var stubbedError: Error?

    /// Records the last endpoint passed to `fetch`.
    private(set) var lastEndpointCalled: Endpoint?

    // MARK: - APIClientProtocol

    func fetch<T: Decodable>(_ endpoint: Endpoint) async throws -> T {
        lastEndpointCalled = endpoint

        if let error = stubbedError {
            throw error
        }

        guard let result = stubbedResult as? T else {
            fatalError("MockAPIClient: stubbedResult is not of expected type \(T.self)")
        }

        return result
    }
}
