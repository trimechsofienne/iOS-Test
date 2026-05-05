//
//  Theme.swift
//  TheGoodCorner
//
//  Created by Sofienne Trimech on 04/05/2026.
//

import SwiftUI

/// Semantic colors that adapt automatically to dark/light mode.
///
/// All views must reference `Theme.xxx` instead of hardcoding colors.
/// Uses `Color(.systemXxx)` and `Color.primary/.secondary` which
/// adapt natively to appearance changes.
enum Theme {
    static let urgentBackground = Color.orange
    static let urgentForeground = Color.white

    static let chipSelectedBackground = Color.primary
    static let chipDefaultBackground = Color(.systemGray5)
    static let chipSelectedForeground = Color(UIColor.systemBackground)
    static let chipDefaultForeground = Color.primary
    static let chipBorder = Color(.systemGray3)

    static let placeholderBackground = Color(.systemGray5)
    static let placeholderIcon = Color.secondary

    static let priceColor = Color.accentColor
    static let secondaryText = Color.secondary
    static let errorIcon = Color.orange
}
