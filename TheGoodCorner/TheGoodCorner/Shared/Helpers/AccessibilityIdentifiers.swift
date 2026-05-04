//
//  AccessibilityIdentifiers.swift
//  TheGoodCorner
//
//  Created by Sofienne Trimech on 04/05/2026.
//

import Foundation

/// Centralized accessibility identifiers for UI testing.
///
/// Using an enum prevents typos and ensures consistency
/// between the app code and UI test assertions.
enum AccessibilityIdentifiers {
    static let listingsScreen = "listings_screen"
    static let detailScreen = "detail_screen"
    static let categoryFilterBar = "category_filter_bar"
    static let retryButton = "retry_button"
    static let listingRow = "listing_row"
    static let urgentBadge = "urgent_badge"
    static let loadingIndicator = "loading_indicator"
    static let emptyState = "empty_state"
    static let errorState = "error_state"
}
