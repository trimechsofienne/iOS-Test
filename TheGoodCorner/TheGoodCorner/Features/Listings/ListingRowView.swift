//
//  ListingRowView.swift
//  TheGoodCorner
//
//  Created by Sofienne Trimech on 05/05/2026.
//

import SwiftUI

/// A single listing row in the list.
///
/// All data is injected — no reference to `DIContainer`.
/// The row builds a full image URL from the relative API path.
struct ListingRowView: View {

    // MARK: - Properties

    let listing: Listing
    let categoryName: String
    let baseURL: URL

    // MARK: - Body

    var body: some View {
        HStack(alignment: .top, spacing: Spacing.m) {
            AsyncCachedImage(url: imageURL)

            VStack(alignment: .leading, spacing: Spacing.xs) {
                if listing.isUrgent {
                    UrgentBadge()
                }

                Text(listing.title)
                    .font(Typography.rowTitle)
                    .lineLimit(2)

                Text(categoryName)
                    .font(Typography.rowCategory)
                    .foregroundStyle(Theme.secondaryText)

                Text(PriceFormatter.format(listing.price))
                    .font(Typography.price)
            }

            Spacer()
        }
        .padding(.vertical, Spacing.xs)
        .accessibilityElement(children: .combine)
        .accessibilityLabel(accessibilityDescription)
        .accessibilityIdentifier(AccessibilityIdentifiers.listingRow)
    }

    // MARK: - Helpers

    private var imageURL: URL? {
        guard let path = listing.imagesURL?.small else { return nil }
        return URL(string: path, relativeTo: baseURL)
    }

    private var accessibilityDescription: String {
        var parts: [String] = []
        if listing.isUrgent {
            parts.append(L10n.accessibilityUrgent)
        }
        parts.append(listing.title)
        parts.append(categoryName)
        parts.append(PriceFormatter.format(listing.price))
        return parts.joined(separator: ". ")
    }
}
