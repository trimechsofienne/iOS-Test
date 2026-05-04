//
//  APIClientProtocol.swift
//  TheGoodCorner
//
//  Created by Sofienne Trimech on 04/05/2026.
//

import Foundation

/// Abstraction for the network client.
///
/// Separated from the implementation to enable dependency injection
/// and mock-based testing without a running server.
protocol APIClientProtocol: Sendable {

    /// The base URL used to resolve relative image paths.
    var baseURL: URL { get }

    /// Fetches and decodes a response for the given endpoint.
    func fetch<T: Decodable>(_ endpoint: Endpoint) async throws -> T
}
