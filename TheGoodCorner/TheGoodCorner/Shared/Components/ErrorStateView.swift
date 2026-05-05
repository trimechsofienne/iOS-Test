//
//  ErrorStateView.swift
//  TheGoodCorner
//
//  Created by Sofienne Trimech on 04/05/2026.
//

import SwiftUI

/// Full-screen error state with a recoverable retry action.
///
/// Satisfies the requirement: "Error states are visible and recoverable."
/// Compatible iOS 16+ (no ContentUnavailableView dependency).
struct ErrorStateView: View {

    // MARK: - Properties

    let message: String
    let onRetry: () -> Void

    // MARK: - Body

    var body: some View {
        VStack(spacing: Spacing.l) {
            Image(systemName: Icon.error)
                .font(.largeTitle)
                .foregroundStyle(Theme.errorIcon)
                .accessibilityHidden(true)

            Text(L10n.errorTitle)
                .font(Typography.sectionTitle)

            Text(message)
                .font(Typography.body)
                .foregroundStyle(Theme.secondaryText)
                .multilineTextAlignment(.center)
                .padding(.horizontal, Spacing.xxl)

            Button(action: onRetry) {
                Text(L10n.retry)
                    .font(Typography.body.bold())
                    .padding(.horizontal, Spacing.xl)
                    .padding(.vertical, Spacing.m)
            }
            .accessibilityLabel(L10n.accessibilityRetry)
            .buttonStyle(.bordered)
            .accessibilityIdentifier(AccessibilityIdentifiers.retryButton)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .accessibilityElement(children: .combine)
        .accessibilityIdentifier(AccessibilityIdentifiers.errorState)
    }
}
