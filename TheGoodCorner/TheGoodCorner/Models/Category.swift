//
//  Category.swift
//  TheGoodCorner
//
//  Created by Sofienne Trimech on 04/05/2026.
//

import Foundation

/// Listing category returned by the `/categories` endpoint.
nonisolated struct Category: Identifiable, Decodable, Equatable, Hashable, Sendable {
    let id: Int
    let name: String
}
