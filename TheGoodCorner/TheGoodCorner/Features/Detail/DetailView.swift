//
//  DetailView.swift
//  TheGoodCorner
//
//  Created by Sofienne Trimech on 05/05/2026.
//

import SwiftUI

/// Detail view presenting all information for a listing.
///
/// Satisfies: "The detail view should present the information returned
/// by the API in a way that feels complete and readable."
/// All data is injected — no reference to `DIContainer`.
struct DetailView: View {

    // MARK: - Properties

    let listing: Listing
    let categoryName: String
    let baseURL: URL

    // MARK: - Body

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: Spacing.l) {
                headerImage
                contentSection
            }
        }
        .navigationTitle(listing.title)
        .navigationBarTitleDisplayMode(.inline)
        .accessibilityIdentifier(AccessibilityIdentifiers.detailScreen)
    }

    // MARK: - Subviews

    private var headerImage: some View {
        AsyncCachedImage(
            url: imageURL,
            size: .infinity,
            cornerRadius: 0
        )
        .frame(maxWidth: .infinity)
        .frame(height: Spacing.detailHeaderImageHeight)
        .clipped()
        .accessibilityLabel(listing.imagesURL != nil ? L10n.accessibilityPhotoAvailable : L10n.accessibilityPhotoUnavailable)
        .accessibilityHidden(listing.imagesURL == nil)
    }

    private var contentSection: some View {
        VStack(alignment: .leading, spacing: Spacing.m) {
            if listing.isUrgent {
                UrgentBadge()
            }

            Text(listing.title)
                .font(Typography.screenTitle)
                .fixedSize(horizontal: false, vertical: true)

            Text(PriceFormatter.format(listing.price))
                .font(Typography.price)
                .foregroundStyle(Theme.priceColor)

            Divider()

            Label {
                Text(categoryName)
                    .font(Typography.chip)
            } icon: {
                Image(systemName: Icon.category)
                    .foregroundStyle(Theme.secondaryText)
            }

            Label {
                Text(listing.creationDate, format: .dateTime.day().month(.wide).year())
                    .font(Typography.chip)
            } icon: {
                Image(systemName: Icon.date)
                    .foregroundStyle(Theme.secondaryText)
            }

            Divider()

            Text(L10n.descriptionTitle)
                .font(Typography.sectionTitle)

            Text(listing.description)
                .font(Typography.body)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(.horizontal, Spacing.l)
        .padding(.bottom, Spacing.xxl)
    }

    // MARK: - Helpers

    private var imageURL: URL? {
        guard let path = listing.imagesURL?.small else { return nil }
        return URL(string: path, relativeTo: baseURL)
    }
}
