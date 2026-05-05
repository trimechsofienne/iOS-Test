//
//  UrgentBadge.swift
//  TheGoodCorner
//
//  Created by Sofienne Trimech on 04/05/2026.
//

import SwiftUI

/// Visual badge indicating an urgent listing.
///
/// Accessibility: announces "Annonce urgente" to VoiceOver users.
/// Uses Dynamic Type-compatible font sizing.
struct UrgentBadge: View {

    // MARK: - Body

    var body: some View {
        Text(L10n.urgent)
            .font(Typography.badge)
            .foregroundStyle(Theme.urgentForeground)
            .padding(.horizontal, Spacing.s)
            .padding(.vertical, Spacing.xs)
            .background(Theme.urgentBackground)
            .clipShape(Capsule())
            .accessibilityLabel(L10n.accessibilityUrgent)
            .accessibilityIdentifier(AccessibilityIdentifiers.urgentBadge)
    }
}
