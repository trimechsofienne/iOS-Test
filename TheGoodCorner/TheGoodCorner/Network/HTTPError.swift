//
//  HTTPError.swift
//  TheGoodCorner
//
//  Created by Sofienne Trimech on 04/05/2026.
//

import Foundation

/// Typed errors for the network layer.
/// Conforms to `Equatable` to enable assertion in tests.
enum HTTPError: Error, LocalizedError, Equatable {

    case invalidURL
    case invalidResponse(statusCode: Int)
    case decodingFailure(String)
    case networkError(String)

    // MARK: - LocalizedError

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return String(localized: "error.invalidURL")
        case .invalidResponse(let code):
            return String(localized: "error.server \(code)")
        case .decodingFailure(let detail):
            return String(localized: "error.decoding \(detail)")
        case .networkError(let detail):
            return String(localized: "error.network \(detail)")
        }
    }
}
