//
//  EmptyStateView.swift
//  TheGoodCorner
//
//  Created by Sofienne Trimech on 04/05/2026.
//

import SwiftUI

/// Full-screen empty state with a contextual message.
///
/// Satisfies the requirement: "Empty states are intentional."
/// Compatible iOS 16+ (no ContentUnavailableView dependency).
struct EmptyStateView: View {

    // MARK: - Properties

    let message: String
    let systemImage: String

    // MARK: - Init

    init(message: String, systemImage: String = Icon.defaultEmpty) {
        self.message = message
        self.systemImage = systemImage
    }

    // MARK: - Body

    var body: some View {
        VStack(spacing: Spacing.l) {
            Image(systemName: systemImage)
                .font(.largeTitle)
                .foregroundStyle(Theme.secondaryText)
                .accessibilityHidden(true)

            Text(message)
                .font(Typography.body)
                .foregroundStyle(Theme.secondaryText)
                .multilineTextAlignment(.center)
                .padding(.horizontal, Spacing.xxl)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .accessibilityIdentifier(AccessibilityIdentifiers.emptyState)
    }
}
