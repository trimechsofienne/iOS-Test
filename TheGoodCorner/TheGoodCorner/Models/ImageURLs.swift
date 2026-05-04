//
//  ImageURLs.swift
//  TheGoodCorner
//
//  Created by Sofienne Trimech on 04/05/2026.
//

import Foundation

/// Image paths returned by the API.
struct ImageURLs: Decodable, Equatable, Hashable, Sendable {
    let small: String?
    let thumb: String?
}
