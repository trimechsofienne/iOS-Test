//
//  PriceFormatter.swift
//  TheGoodCorner
//
//  Created by Sofienne Trimech on 04/05/2026.
//

import Foundation

/// Centralized price formatting.
///
/// Used in both visible UI and accessibility labels to ensure
/// consistent currency display across the app.
enum PriceFormatter {

    /// Formats a price as a localized EUR currency string.
    /// Example: `140.0` → `"140,00 €"` (fr) or `"€140.00"` (en)
    static func format(_ price: Double) -> String {
        price.formatted(.currency(code: "EUR"))
    }
}
