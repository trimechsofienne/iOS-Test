//
//  APIClient.swift
//  TheGoodCorner
//
//  Created by Sofienne Trimech on 04/05/2026.
//

import Foundation

/// Concrete implementation of `APIClientProtocol`.
///
/// Accepts an `Endpoint`, builds the request internally,
/// and returns a decoded response. The caller never constructs
/// raw `URLRequest` objects or accesses `baseURL` for requests.
final class APIClient: APIClientProtocol, @unchecked Sendable {

    // MARK: - Properties

    let baseURL: URL
    private let session: URLSession
    private let decoder: JSONDecoder

    // MARK: - Init

    init(
        baseURL: URL = URL(string: "http://localhost:8080")!,
        session: URLSession = .shared
    ) {
        self.baseURL = baseURL
        self.session = session

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        self.decoder = decoder
    }

    // MARK: - APIClientProtocol

    func fetch<T: Decodable>(_ endpoint: Endpoint) async throws -> T {
        guard let request = endpoint.urlRequest(baseURL: baseURL) else {
            throw HTTPError.invalidURL
        }

        let data: Data
        let response: URLResponse

        do {
            (data, response) = try await session.data(for: request)
        } catch {
            throw HTTPError.networkError(error.localizedDescription)
        }

        guard let http = response as? HTTPURLResponse else {
            throw HTTPError.networkError("Unexpected response type.")
        }

        guard (200..<300).contains(http.statusCode) else {
            throw HTTPError.invalidResponse(statusCode: http.statusCode)
        }

        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            throw HTTPError.decodingFailure(error.localizedDescription)
        }
    }
}
